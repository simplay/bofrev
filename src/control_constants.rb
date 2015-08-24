module ControlConstants
  if (RUBY_PLATFORM == "java")
    A_KEY = 'keyTyped_a'
    W_KEY = 'keyTyped_w'
    D_KEY = 'keyTyped_d'
    S_KEY = 'keyTyped_s'
    LEFT_MOUSE_BUTTON_PRESSED =  'mouseClicked_1'
    LEFT_MOUSE_BUTTON_DRAGGED =  'mouseDragged_1'
    W_D_KEYS = 'w,d'
    W_A_KEYS = 'w,a'

    A_PRESSED = 'keyPressed_a'
    D_PRESSED = 'keyPressed_d'

    D_RELEASED = 'keyReleased_d'
    A_RELEASED = 'keyReleased_a'
    S_RELEASED = 'keyReleased_s'
  else
    A_KEY = 'a'
    W_KEY = 'w'
    D_KEY = 'd'
    S_KEY = 's'
    LEFT_MOUSE_BUTTON_PRESSED =  'ButtonPress-1'
    LEFT_MOUSE_BUTTON_DRAGGED =  'B1-Motion'
    W_D_KEYS = 'w,d'
    W_A_KEYS = 'w,a'

    A_PRESSED = 'KeyPress-a'
    D_PRESSED = 'KeyPress-d'

    D_RELEASED = 'KeyRelease-d'
    A_RELEASED = 'KeyRelease-a'
    S_RELEASED = 'KeyRelease-s'
  end
end
