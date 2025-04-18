import Core
import TradeDeskDomain
import TradeDeskData

public class CandleDomainMapper: BaseDomainMapper {
    public init() {}
    
    public func fromDataModelToDomainModel(data: any BaseDataModel) -> any BaseDomainModel {
        guard let dataModel = data as? CandleDataModel else {
                    fatalError("Invalid data model type passed to CandleDomainMapper")
                }
                
                let domainModel: CandleDomainModel = dataModel.map { row in
                    row.map { element in
                        switch element {
                        case .integer(let value):
                            return .integer(value)
                        case .string(let value):
                            return .string(value)
                        }
                    }
                }
                
        return domainModel
    }
}
