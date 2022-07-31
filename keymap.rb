# This keymap works on 0.9.17+

require "via"
require "consumer_key"

puts "==== Shotgun CherryPie ===="

kbd = Keyboard.new

# Use this pins if you have the production version
kbd.init_pins(
  [ 9, 10, 11, 12, 14 ], # row0, row1,... respectively
  [ 5, 4, 2, 3 ]         # col0, col1,... respectively
)

# Pins of a prototype PCB
#kbd.init_pins(
#  [ 11, 12, 13, 14, 15 ], # row0, row1,... respectively
#  [ 9, 8, 7, 6]           # col0, col1,... respectively
#)


# This keymap assumes it has five encoders on the left-most column

encoder_1 = RotaryEncoder.new(28, 27)
encoder_1.clockwise do
  kbd.send_key :KC_RGUI, :KC_RCTL, :KC_RIGHT
end
encoder_1.counterclockwise do
  kbd.send_key :KC_RGUI, :KC_RCTL, :KC_LEFT
end
kbd.append encoder_1

encoder_2 = RotaryEncoder.new(26, 22)
encoder_2.clockwise do
  kbd.send_key :KC_LCTL, :KC_TAB
end
encoder_2.counterclockwise do
  kbd.send_key :KC_LCTL, :KC_LSFT, :KC_TAB
end
kbd.append encoder_2

encoder_3 = RotaryEncoder.new(21, 20)
encoder_3.clockwise do
  kbd.send_key %i(KC_LALT KC_TAB)
end
encoder_3.counterclockwise do
  kbd.send_key %i(KC_LALT KC_LSFT KC_TAB)
end
kbd.append encoder_3

encoder_4 = RotaryEncoder.new(19, 18)
encoder_4.clockwise do
  kbd.send_key :KC_VOLU
end
encoder_4.counterclockwise do
  kbd.send_key :KC_VOLD
end
kbd.append encoder_4

encoder_5 = RotaryEncoder.new(17, 16)
encoder_5.clockwise do
  kbd.send_key :RGB_SPI
end
encoder_5.counterclockwise do
  kbd.send_key :RGB_SPD
end
kbd.append encoder_5

rgb = RGB.new(
  0,
  28,
  0,
  false
)
rgb.effect = :swirl
kbd.append rgb

kbd.add_layer :default, %i[
  KC_NO  BOOTSEL  KC_NO    KC_NUMLOCK
  KC_NO  KC_KP_7  KC_KP_8  KC_KP_9
  KC_NO  KC_KP_4  KC_KP_5  KC_KP_6
  KC_NO  KC_KP_1  KC_KP_2  KC_KP_3
  KC_NO  KC_KP_0  KC_NO    KC_KP_DOT
]

kbd.define_mode_key :BOOTSEL, [ Proc.new { kbd.bootsel! }, nil, 300, nil ]

kbd.start!
