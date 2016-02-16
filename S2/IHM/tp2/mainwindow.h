#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTextEdit>
#include <QFileDialog>
#include <QTextStream>
#include <iostream>
#include "zonedessin.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    ZoneDessin *zd;
    Ui::MainWindow *ui;
    QMenuBar* fmenuBar;
    QMenu* file;

    QAction* open;
    QAction* save;
    QAction* quit;

    QToolBar* fileToolBar;
    QTextEdit* textEdit;

public slots:
    void openFile();
    void saveFile();
};

#endif // MAINWINDOW_H
