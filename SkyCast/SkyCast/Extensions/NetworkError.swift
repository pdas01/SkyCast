import Foundation

enum NetworkError: Error {
    case decodingError(String)
    case error(String)
    case serverError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError(_), .serverError(_):
            return AppStrings.Error.genericError.value
        case .error(let msg):
            return msg
        }
    }
}
