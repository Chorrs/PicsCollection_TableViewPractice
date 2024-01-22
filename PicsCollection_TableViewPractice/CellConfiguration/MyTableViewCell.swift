//
//  MyTableViewCell.swift
//  PicsCollection_TableViewPractice
//
//  Created by Chorrs on 7.01.24.
//

import UIKit

final class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var path: String?
    
    // метод будет вызываться каждый раз за несколько мгновений до того, как ячейка будет переиспользована, чтобы пользователь не видел старые картинки, пока не загрузятся новые
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    // 1) преобразовали путь в юрл
    // 2) по юрл скачали дату в виде байтов
    // 3) преобразовали байты в картинку
    // если всё успешно - отображаем картинку в ячейке
    func configure(path: String) {
        self.path = path
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            if let url = URL(string: path),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data),
               path == self?.path {
                
                DispatchQueue.main.async {
                    self?.photoImageView.image = image
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
/*
 `self.path = path` присваивает переданный путь (URL) свойству `path` внутри объекта ячейки. Это нужно для того, чтобы в дальнейшем проверить, совпадает ли текущий путь с путем, который был передан в момент настройки ячейки.

 `path == self?.path` является частью условия, которое проверяет, совпадает ли текущий путь (`self?.path`) с путем, который был сохранен в `self.path`. Это условие важно для избежания проблем при асинхронной загрузке данных.

 Почему это нужно:

 1. Ячейки таблицы могут быть переиспользованы для разных элементов данных. Если таблица прокручивается и ячейка, загружающая изображение по URL, не завершила загрузку до того, как она стала видимой, то она может быть переиспользована для другого элемента данных с другим URL.

 2. Если не проверять совпадение путей, то ячейка может начать загружать изображение для старого URL, тогда как в методе `configure` уже был передан новый URL. Это может привести к тому, что в ячейке отобразится неверное изображение, и пользователь увидит "мелькание" неправильных данных.

 Так, условие `path == self?.path` гарантирует, что изображение загружается только для последнего установленного URL, и избегает конфликтов при асинхронной загрузке.
 */
