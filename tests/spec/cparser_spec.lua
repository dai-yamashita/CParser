-- Copyright (c) Facebook, Inc. and its affiliates.
-- This source code is licensed under the MIT license found in the
-- LICENSE file in the root directory of this source tree.

-- Note: This test case was originally contributed by
-- Javier <nanoterrain@yahoo.com> in git commit c6cf0b6fa31
-- and licensed under the facebook CLA. */


describe('cparser', function()
  local cparser = require('cparser')

  local function get_enum_action(actions)
    local enum = {}

    for action in actions do
      enum = action
    end

    return enum
  end

  it('should be able to parse an enum', function()
    local actions = cparser.declarationIterator({}, io.lines('tests/tstenum.h'), 'tests/tstenum.h')

    local actual = get_enum_action(actions)

    local expected = {
      tag = 'TypeDef',
      name = 'SomeEnumeration',
      where = 'tests/tstenum.h:1',
      sclass = 'typedef',
      type = {
        tag = 'Enum',
        { tag = 'Pair', 'ValueOne' },
        { tag = 'Pair', 'ValueTwo', 1 },
        { tag = 'Pair', 'ValueThree' },
        { tag = 'Pair', 'ValueFour', 0 }
      }
    }

    assert.are.same(expected, actual)
  end)
end)
