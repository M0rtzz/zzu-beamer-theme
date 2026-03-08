if emoji == nil then
  emoji = {}
end

emoji.direct_input = emoji.direct_input or {}

local direct_input = emoji.direct_input
direct_input.trie = direct_input.trie or {}
direct_input.enabled = direct_input.enabled or false

local backslash = string.char(92)
local variation_selector_15 = 0xFE0E
local variation_selector_16 = 0xFE0F

local function is_variation_selector(codepoint)
  return codepoint == variation_selector_15 or codepoint == variation_selector_16
end

local function parse_sequence(sequence)
  local codepoints = {}
  for _, codepoint in utf8.codes(sequence) do
    if not is_variation_selector(codepoint) then
      codepoints[#codepoints + 1] = codepoint
    end
  end
  return codepoints
end

local function find_unescaped_comment(line)
  local position = 1
  while true do
    local index = line:find("%", position, true)
    if not index then
      return nil
    end
    local slash_count = 0
    for i = index - 1, 1, -1 do
      if line:sub(i, i) ~= backslash then
        break
      end
      slash_count = slash_count + 1
    end
    if slash_count % 2 == 0 then
      return index
    end
    position = index + 1
  end
end

local function split_codepoints(text)
  local original_positions = {}
  local original_codepoints = {}
  local codepoints = {}
  local start_positions = {}
  local end_positions = {}
  local original_count = 0
  local count = 0

  for position, codepoint in utf8.codes(text) do
    original_count = original_count + 1
    original_positions[original_count] = position
    original_codepoints[original_count] = codepoint
    if not is_variation_selector(codepoint) then
      count = count + 1
      codepoints[count] = codepoint
      start_positions[count] = position
      end_positions[count] = nil
    end
  end

  original_positions[original_count + 1] = #text + 1

  if count > 0 then
    local next_non_variation_index = count + 1
    for i = original_count, 1, -1 do
      if not is_variation_selector(original_codepoints[i]) then
        next_non_variation_index = next_non_variation_index - 1
        if next_non_variation_index < count then
          end_positions[next_non_variation_index] = start_positions[next_non_variation_index + 1]
        else
          end_positions[next_non_variation_index] = original_positions[original_count + 1]
        end
      end
    end
  end

  return codepoints, start_positions, end_positions
end

local function replace_sequences(text)
  local trie = direct_input.trie
  if next(trie) == nil then
    return text
  end

  local codepoints, start_positions, end_positions = split_codepoints(text)
  local count = #codepoints
  if count == 0 then
    return text
  end
  local output = nil
  local index = 1
  local segment_begin = 1

  while index <= count do
    local node = trie[codepoints[index]]
    if not node then
      index = index + 1
    else
      local end_index = index
      local best_sequence = node.sequence
      local best_end_index = best_sequence and index or nil
      while end_index < count do
        local next_node = node[codepoints[end_index + 1]]
        if not next_node then
          break
        end
        node = next_node
        end_index = end_index + 1
        if node.sequence then
          best_sequence = node.sequence
          best_end_index = end_index
        end
      end

      if best_sequence then
        if not output then
          output = {}
        end
        if segment_begin < start_positions[index] then
          output[#output + 1] = text:sub(segment_begin, start_positions[index] - 1)
        end
        output[#output + 1] = backslash .. "emojiinput{" .. best_sequence .. "}"
        segment_begin = end_positions[best_end_index]
        index = best_end_index + 1
      else
        index = index + 1
      end
    end
  end

  if not output then
    return text
  end
  if segment_begin <= #text then
    output[#output + 1] = text:sub(segment_begin)
  end
  return table.concat(output)
end

function emoji.register_sequence(sequence)
  local codepoints = parse_sequence(sequence)
  if #codepoints == 0 then
    return
  end
  local node = direct_input.trie
  for i = 1, #codepoints do
    local codepoint = codepoints[i]
    node[codepoint] = node[codepoint] or {}
    node = node[codepoint]
  end
  node.sequence = sequence
end

function emoji.process_input_buffer(line)
  local comment_start = find_unescaped_comment(line)
  if comment_start then
    local content = line:sub(1, comment_start - 1)
    local comment = line:sub(comment_start)
    return replace_sequences(content) .. comment
  end
  return replace_sequences(line)
end

function emoji.enable_direct_input()
  if direct_input.enabled then
    return
  end
  if luatexbase and luatexbase.add_to_callback then
    luatexbase.add_to_callback(
      "process_input_buffer",
      emoji.process_input_buffer,
      "emoji.process_input_buffer"
    )
  else
    callback.register("process_input_buffer", emoji.process_input_buffer)
  end
  direct_input.enabled = true
end
