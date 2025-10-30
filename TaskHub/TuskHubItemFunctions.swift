//
//  TuskHubItemFunctions.swift
//  TaskHub
//
//  Created by Marcos Tito on 24/10/25.
//

import Foundation
import CoreData



func getAllItems(in context: NSManagedObjectContext) -> [TuskHubItem] {
    let request: NSFetchRequest<TuskHubItem> = TuskHubItem.fetchRequest()
    do {
        return try context.fetch(request)
    } catch {
        print("❌ Error al obtener TuskHubItem: \(error)")
        return []
    }
}

@discardableResult
func createItem(name: String, desc: String?, in context: NSManagedObjectContext) -> TuskHubItem? {
    let item = TuskHubItem(context: context)
    item.name = name
    item.desc = desc
    item.date = Date()
    
    do {
        try context.save()
        print("✅ Tarea guardada correctamente: \(name)")
        return item
    } catch {
        print("❌ Error al guardar TuskHubItem: \(error)")
        context.rollback()
        return nil
    }
}

func deleteItem(_ item: TuskHubItem, in context: NSManagedObjectContext) {
    context.delete(item)
    do {
        try context.save()
        print("🗑️ Tarea eliminada correctamente.")
    } catch {
        print("❌ Error al eliminar TuskHubItem: \(error)")
        context.rollback()
    }
}


func updateItem(_ item: TuskHubItem, in context: NSManagedObjectContext) {
    do {
        try context.save()
        print("✏️ Tarea actualizada correctamente.")
    } catch {
        print("❌ Error al actualizar TuskHubItem: \(error)")
        context.rollback()
    }
}
