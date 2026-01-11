import Foundation
import SwiftUI

enum QuizTopic: CaseIterable, Identifiable {
    case coordinator1
    case coordinator2
    case health1
    case health2
    case counseling1
    case counseling2
    case environment1
    case environment2
    case welfare1
    case welfare2
    case marubatsuElderlyDisabled
    case marubatsuElderlyDisabled2
    case marubatsuElderlyDisabled3
    case selectionElderlyDisabled
    case marubatsuHealthDisabilities
    case marubatsuHealthDisabilities2
    case marubatsuHealthDisabilities3
    case selectionHealthDisabilities
    case selectionHealthDisabilities2
    case marubatsuLivingEnvironment
    case selectionLivingEnvironment
    case frequentQuestion1
    case frequentQuestion2
    case frequentQuestion3
    case frequentQuestion4
    case frequentQuestion5
    case basicQuestionsPart1
    case basicQuestionsPart2
    case basicQuestionsPart3
    case basicQuestionsPart4
    case basicQuestionsPart5



    
    var id: String { category }
    
    var title: String { category }
    
    var category: String {
        switch self {
        case .coordinator1: return "福祉住環境コーディネーターの役割 1"
        case .coordinator2: return "福祉住環境コーディネーターの役割 2"
        case .health1:      return "疾患・障害別住環境整備 1"
        case .health2:      return "疾患・障害別住環境整備 2"
        case .counseling1:  return "相談援助技術 1"
        case .counseling2:  return "相談援助技術 2"
        case .environment1: return "住環境整備の技術 1"
        case .environment2: return "住環境整備の技術 2"
        case .welfare1:     return "福祉用具の活用 1"
        case .welfare2:     return "福祉用具の活用 2"
        case .marubatsuElderlyDisabled: return "【◯✖️】高齢者障害者"
        case .marubatsuElderlyDisabled2: return "【◯✖️】高齢者障害者2"
        case .marubatsuElderlyDisabled3: return "【◯✖️】高齢者障害者3"
        case .selectionElderlyDisabled: return "選択 高齢者障害者"
        case .marubatsuHealthDisabilities: return "【◯✖️】健康・障害"
        case .marubatsuHealthDisabilities2: return "🩷【◯✖️】健康・障害2"
        case .marubatsuHealthDisabilities3: return "【◯✖️】健康・障害3"
        case .selectionHealthDisabilities: return "【選択】健康・障害"
        case .selectionHealthDisabilities2: return "【選択】健康・障害2"
        case .marubatsuLivingEnvironment: return "【◯✖️】住環境整備"
        case .selectionLivingEnvironment: return "【選択】住環境整備"
        case .frequentQuestion1: return "よく出る問題 1"
        case .frequentQuestion2: return "よく出る問題 2"
        case .frequentQuestion3: return "よく出る問題 3"
        case .frequentQuestion4: return "よく出る問題 4"
        case .frequentQuestion5: return "よく出る問題 5"
        case .basicQuestionsPart1: return "問題1-10"
        case .basicQuestionsPart2: return "問題11-20"
        case .basicQuestionsPart3: return "問題21-30"
        case .basicQuestionsPart4: return "問題31-40"
        case .basicQuestionsPart5: return "問題41-50"
        }
    }
    
    var fileName: String {
        switch self {
        case .coordinator1: return "coordinator_1"
        case .coordinator2: return "coordinator_2"
        case .health1:      return "health_1"
        case .health2:      return "health_2"
        case .counseling1:  return "counseling_1"
        case .counseling2:  return "counseling_2"
        case .environment1: return "environment_1"
        case .environment2: return "environment_2"
        case .welfare1:     return "welfare_1"
        case .welfare2:     return "welfare_2"
        case .marubatsuElderlyDisabled: return "marubatsu_elderly_disabled"
        case .marubatsuElderlyDisabled2: return "marubatsu_elderly_disabled_2"
        case .marubatsuElderlyDisabled3: return "marubatsu_elderly_disabled_3"
        case .selectionElderlyDisabled: return "selection_elderly_disabled"
        case .marubatsuHealthDisabilities: return "marubatsu_health_disabilities"
        case .marubatsuHealthDisabilities2: return "marubatsu_health_disabilities_2"
        case .marubatsuHealthDisabilities3: return "marubatsu_health_disabilities_3"
        case .selectionHealthDisabilities: return "selection_health_disability"
        case .selectionHealthDisabilities2: return "selection_health_disability_2"
        case .marubatsuLivingEnvironment: return "marubatsu_living_environment"
        case .selectionLivingEnvironment: return "selection_living_environment"
        case .frequentQuestion1: return "frequent_question_1"
        case .frequentQuestion2: return "frequent_question_2"
        case .frequentQuestion3: return "frequent_question_3"
        case .frequentQuestion4: return "frequent_question_4"
        case .frequentQuestion5: return "frequent_question_5"
        case .basicQuestionsPart1: return "basic_questions_part1"
        case .basicQuestionsPart2: return "basic_questions_part2"
        case .basicQuestionsPart3: return "basic_questions_part3"
        case .basicQuestionsPart4: return "basic_questions_part4"
        case .basicQuestionsPart5: return "basic_questions_part5"
        }
    }
    
    var isMaruBatsu: Bool {
        switch self {
        case .marubatsuElderlyDisabled, .marubatsuElderlyDisabled2, .marubatsuElderlyDisabled3, .marubatsuHealthDisabilities, .marubatsuHealthDisabilities2, .marubatsuHealthDisabilities3, .marubatsuLivingEnvironment, .frequentQuestion1, .frequentQuestion2, .frequentQuestion3, .frequentQuestion4, .frequentQuestion5, .basicQuestionsPart1, .basicQuestionsPart2, .basicQuestionsPart3, .basicQuestionsPart4, .basicQuestionsPart5:



            return true
        default:
            return false
        }
    }
}

enum QuizChapter: String, CaseIterable, Identifiable {
    case basic = "よく出る問題part1"
    case frequent = "よく出る問題part2"



    
    var id: String { rawValue }
    
    var title: String { rawValue }
    
    var topics: [QuizTopic] {
        switch self {
        case .frequent:
            return [
                .frequentQuestion1,
                .frequentQuestion2,
                .frequentQuestion3,
                .frequentQuestion4,
                .frequentQuestion5
            ]
        case .basic:
            return [
                .basicQuestionsPart1,
                .basicQuestionsPart2,
                .basicQuestionsPart3,
                .basicQuestionsPart4,
                .basicQuestionsPart5
            ]




        }
    }
    
    var color: Color {
        switch self {
        case .frequent, .basic:
             return Color(red: 0.2, green: 0.7, blue: 0.9) // Light Blue (Mizuiro)


        }
    }
}
