# lib/magic/blackboard_overlay.rb
module Magic
  class BlackboardOverlay
    def self.compose_overlay(photo_path:, output_path:, text_data:)
      require 'mini_magick'

      # 元写真と黒板テンプレートを読み込み
      photo = MiniMagick::Image.open(photo_path)
      blackboard = MiniMagick::Image.open(Rails.root.join("app/assets/images/blackboard_base.png"))

      # 黒板サイズを写真の幅の約1/3に縮小（高さは自動）
      blackboard.resize "#{(photo.width / 3).to_i}x"

      # 黒板に文字を1行ずつ描画
      Rails.logger.info "フォントパス: #{Rails.root.join("app/assets/fonts/ipaexg.ttf")}"
      blackboard.combine_options do |c|
        c.gravity "NorthWest"
        c.font Rails.root.join("app/assets/fonts/ipaexg.ttf").to_s
        c.fill "white"

        font_size = (blackboard.height * 0.06).to_i
        c.pointsize font_size
        y = 20
        line_height = (font_size * 1.3).to_i

        lines = []
        lines << "年月日: #{text_data[:date]}"
        lines << "工事番号: #{text_data[:work_number].to_s.gsub('-', '－')}"
        lines << "工事件名: #{text_data[:project_name]}"
        lines += text_data[:work_content].to_s.split(/\r?\n/)
        lines << "箇所: #{text_data[:location]}"
        lines << "施工者: #{text_data[:contractor]}"

        lines.each do |line|
          escaped_line = line.gsub('"', '\"')
          c.draw "text 20,#{y} \"#{escaped_line}\""
          y += line_height
        end
      end

      # 写真に黒板を左下に合成
      result = photo.composite(blackboard) do |c|
        c.gravity "SouthWest"  # 左下に配置
        c.geometry "+10+10"    # 余白を少し空ける
      end

      result.write(output_path)
    end
  end
end