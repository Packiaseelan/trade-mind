/// A protocol that defines the requirements for a domain mapper.
/// This protocol is responsible for converting data models into domain models.
public protocol BaseDomainMapper {
    /// Converts a data model into a domain model.
    /// - Parameter data: The data model to be converted.
    /// - Returns: The corresponding domain model.
    func fromDataModelToDomainModel(data: BaseDataModel) -> BaseDomainModel
}

/// A protocol that represents a base data model.
/// This protocol serves as a marker for data models, which are typically used to represent
/// data structures received from external sources such as APIs or databases.
public protocol BaseDataModel {
    // Define properties or methods common to all data models here, if needed.
}

/// A protocol that represents a base domain model.
/// This protocol serves as a marker for domain models, which are typically used to represent
/// business logic entities within the application.
public protocol BaseDomainModel {
    // Define properties or methods common to all domain models here, if needed.
}
