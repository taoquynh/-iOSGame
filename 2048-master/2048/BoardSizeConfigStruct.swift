import UIKit

/// Cài đặt kích thước bảng
struct BoardSizeConfig {
  
  /// Số lượng gạch liên tiếp
  let tileNumber = 4
  
  /// Tổng số gạch trong trò chơi
  let tileCount = 16
  
  // Kích cỡ khác nhau
  let boardSize = CGSize(width: 290, height: 290)
  let tileSize = CGSize(width: 60, height: 60)
  let borderSize = CGSize(width: 10, height: 10)
}
