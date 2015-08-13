#!/usr/local/bin/jruby

include Java

import java.awt.Color
import javax.swing.JFrame
import javax.swing.JPanel

class Canvas < JPanel

    DX = 20
    def paintComponent g
        self.drawColorRectangles g
    end

    def drawColorRectangles g
        5.times do |i|
          5.times do |j|
            g.setColor Color.new rand(255), rand(255), rand(255)
            g.fillRect(10+120*i, 15+90*j, 90, 60)
          end
        end
    end
end

class Example < JFrame

    def initialize
        super "Colors"
        self.initUI
        @thread = Thread.new do
          loop do
            1_000_000.times do ; end
            @canvas.repaint
          end
        end
    end

    def initUI
        @canvas = Canvas.new
        self.getContentPane.add @canvas
        self.setDefaultCloseOperation JFrame::EXIT_ON_CLOSE
        self.setSize 700, 700
        self.setLocationRelativeTo nil
        self.setVisible true
    end
end

Example.new
