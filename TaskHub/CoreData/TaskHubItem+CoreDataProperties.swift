//
//  TaskHubItem+CoreDataProperties.swift
//  TaskHub
//
//  Created by Marcos Tito on 30/10/25.
//

import Foundation
import CoreData

extension TaskHubItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskHubItem> {
        return NSFetchRequest<TaskHubItem>(entityName: "TaskHubItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var desc: String?
}

extension TaskHubItem: Identifiable {}

// MARK: - Core Data CRUD helpers


func getAllItems(in context: NSManagedObjectContext) -> [TaskHubItem] {
    let request: NSFetchRequest<TaskHubItem> = TaskHubItem.fetchRequest()
    do {
        return try context.fetch(request)
    } catch {
        print("❌ Error al obtener TaskHubItem: \(error)")
        return []
    }
}


@discardableResult
func createItem(name: String, desc: String?, in context: NSManagedObjectContext) -> TaskHubItem? {
    guard let entity = NSEntityDescription.entity(forEntityName: "TaskHubItem", in: context) else {
        print("❌ No se encontró la entidad 'TaskHubItem' en el modelo.")
        return nil
    }

    let item = TaskHubItem(entity: entity, insertInto: context)
    item.name = name
    item.desc = desc
    item.date = Date()

    do {
        try context.save()
        print("✅ Nueva tarea guardada: \(name)")
        return item
    } catch {
        print("❌ Error al guardar TaskHubItem: \(error)")
        context.rollback()
        return nil
    }
}


func deleteItem(_ item: TaskHubItem, in context: NSManagedObjectContext) {
    context.delete(item)
    do {
        try context.save()
        print("🗑️ Tarea eliminada correctamente.")
    } catch {
        print("❌ Error al eliminar TaskHubItem: \(error)")
        context.rollback()
    }
}


func updateItem(item: TaskHubItem, name: String, desc: String?, in context: NSManagedObjectContext) -> Bool {
    item.name = name
    item.desc = desc
    
    do {
        try context.save()
        print("✏️ Tarea actualizada (campos) correctamente: \(name)")
        return true
    } catch {
        print("❌ Error al actualizar campos de TaskHubItem: \(error)")
        context.rollback()
        return false
    }
}
