import SwiftUI

struct ResultView: View {
    let topic: QuizTopic
    let correctAnswers: Int
    let totalQuestions: Int
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    private var scorePercentage: Double {
        if totalQuestions == 0 { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }
    
    private var scoreLevel: Int {
        let level = Int(scorePercentage / 10)
        return min(level, 9) // 100% is treated as level 9 (90-100 range) for array indexing if needed, or just handle 100 separately
    }
    
    private var resultComment: String {
        switch Int(scorePercentage) {
        case 0...10:
            return "教本を読み返して、交通ルールの基礎から確認しましょう。"
        case 11...20:
            return "少しずつ理解できています。\n標識や標示の意味もしっかり覚えましょう。"
        case 21...30:
            return "あと一歩で半分です！\n旅客の安全を守る意識を持って学習しましょう。"
        case 31...40:
            return "基礎知識はついてきました。\n二種免許特有の問題にも慣れていきましょう。"
        case 41...50:
            return "折り返し地点です！\nお客様を乗せているつもりで、慎重に判断しましょう。"
        case 51...60:
            return "合格圏内が見えてきました！\n危険予測や応急救護の知識も深めましょう。"
        case 61...70:
            return "良い調子です！\nひっかけ問題に注意して、正確な知識を定着させましょう。"
        case 71...80:
            return "素晴らしい！プロのドライバーとしての自覚を持って、さらに磨きをかけましょう。"
        case 81...90:
            return "非常に優秀です！\n本番でも冷静に判断できるよう、最終確認を行いましょう。"
        default: // 91-100
            return "完璧です！自信を持って本番に臨んでください。\nプロドライバーとして即戦力の知識レベルです。"
        }
    }
    
    private var feedbackIcon: String {
        switch Int(scorePercentage) {
        case 0...30: return "figure.walk"
        case 31...60: return "figure.run"
        case 61...100: return "crown.fill"
        default: return "figure.walk"
        }
    }
    
    private var feedbackColor: Color {
        switch Int(scorePercentage) {
        case 0...30: return Color(red: 1.0, green: 0.4, blue: 0.4) // Reddish
        case 31...60: return Color(red: 1.0, green: 0.6, blue: 0.2) // Orange
        case 61...100: return Color(red: 1.0, green: 0.8, blue: 0.2) // Gold/Yellow
        default: return .gray
        }
    }
    
    var body: some View {
        ZStack {
            // 背景
            Color(red: 0.85, green: 0.92, blue: 1.0)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // ヘッダー
                    VStack(spacing: 8) {
                        Text("クイズ結果")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text(topic.title)
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 20)
                    
                    // スコアカード
                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            Text(scorePercentage >= 80 ? "素晴らしい！" : (scorePercentage >= 60 ? "合格圏内" : "導入期"))
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.4))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(red: 1.0, green: 0.9, blue: 0.9))
                                .cornerRadius(20)
                            Spacer()
                        }
                        
                        VStack(spacing: 8) {
                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                Text("\(Int(scorePercentage))")
                                    .font(.system(size: 64, weight: .bold))
                                    .foregroundColor(.black)
                                Text("% 正解")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                            }
                            
                            Text("\(correctAnswers) / \(totalQuestions) 問")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        
                        // プログレスバー
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 8)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 1.0, green: 0.4, blue: 0.4))
                                    .frame(width: geometry.size.width * CGFloat(scorePercentage / 100), height: 8)
                            }
                        }
                        .frame(height: 8)
                        .padding(.horizontal, 20)
                    }
                    .padding(.vertical, 30)
                    .background(Color.white)
                    .cornerRadius(24)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    
                    // フィードバックカード
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(alignment: .top, spacing: 16) {
                            Circle()
                                .fill(feedbackColor)
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Image(systemName: feedbackIcon)
                                        .foregroundColor(.white)
                                        .font(.system(size: 24))
                                )
                            
                            Text(resultComment)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .lineSpacing(4)
                        }
                        
                        // イラスト
                        HStack {
                            Spacer()
                            if let uiImage = UIImage(named: "woman_illustration") ??
                               UIImage(contentsOfFile: Bundle.main.path(forResource: "woman_illustration", ofType: "png", inDirectory: "Assets") ?? "") ??
                               UIImage(contentsOfFile: Bundle.main.bundlePath + "/woman_illustration.png") ??
                               UIImage(contentsOfFile: "/Users/kukkiiboy/Desktop/アンチグラビティ/福祉2級のデータ修理/hukusijuukankyou2kyuu/Resources/Assets/woman_illustration.png") {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 160)
                            } else {
                                Image(systemName: "trophy.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(Color(red: 0.9, green: 0.8, blue: 0.4))
                                    .padding(40)
                                    .background(Color.gray.opacity(0.05))
                                    .cornerRadius(20)
                            }
                            Spacer()
                        }
                        
                        Divider()
                        
                        // 次の一歩
                        VStack(alignment: .leading, spacing: 12) {
                            Text("次の一歩")
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                NextStepRow(text: "旅客の安全を守る知識を身につける")
                                NextStepRow(text: "応急救護や危険予測の理解を深める")
                                NextStepRow(text: "毎日少しずつ問題を解いて慣れる")
                            }
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(24)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 20)
                    
                    // ボタン
                    Button(action: {
                        AdsManager.shared.showInterstitialAndReturnToRoot()
                    }) {
                        Text("最初に戻る")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color(red: 0.2, green: 0.4, blue: 0.8))
                            .cornerRadius(28)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct NextStepRow: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Circle()
                .fill(Color(red: 1.0, green: 0.4, blue: 0.4))
                .frame(width: 6, height: 6)
                .padding(.top, 6)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}