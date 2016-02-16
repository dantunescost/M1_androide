#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QPushButton>
#include <QSpinBox>


MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    //ui->setupUi(this);
    this->statusBar();

    this->setFixedSize(700,550);
    this->fmenuBar = menuBar();
    this->file = fmenuBar->addMenu(tr("&File"));

    this->open = new QAction(QIcon(":/images/open.png"),tr("&Open..."), this);
    this->save = new QAction(QIcon(":/images/save.png"),tr("&Save..."), this);
    this->quit = new QAction(QIcon(":/images/quit.png"),tr("&Quit..."), this);
    QAction* color = new QAction(tr("&Color"), this);
    QAction* dash = new QAction(tr("&Dash"), this);
    QAction* dot = new QAction(tr("&Dot"), this);

    dot->setObjectName("dot");

    QSpinBox* slider = new QSpinBox(this);
    slider->setRange(1,20);
    slider->setSingleStep(1);

    QAction* line = new QAction(tr("&Ligne"), this);
    QAction* circle = new QAction(tr("&Circle"), this);
    QAction* rect = new QAction(tr("&Rectangle"), this);

    line->setObjectName("line");
    circle->setObjectName("circle");
    rect->setObjectName("rect");

    QAction* deleteOne = new QAction(tr("&Effacer 1"), this);
    QAction* deleteAll = new QAction(tr("&Effacer tout"), this);

    deleteOne->setObjectName("del1");
    deleteAll->setObjectName("delall");

    open->setStatusTip(tr("Open file"));
    save->setStatusTip(tr("Save file"));
    quit->setStatusTip(tr("Quit"));
    color->setStatusTip(tr("Color"));
    line->setStatusTip(tr("Ligne"));
    circle->setStatusTip(tr("Cercle"));
    rect->setStatusTip(tr("Rectangle"));
    deleteOne->setStatusTip(tr("Supprimer la derniere forme"));
    deleteAll->setStatusTip(tr("Tout supprimer"));

    file->addAction(open);
    file->addAction(save);
    file->addAction(quit);

    this->fileToolBar = addToolBar(tr("File"));
    this->fileToolBar->addAction(open);
    this->fileToolBar->addAction(save);
    this->fileToolBar->addAction(quit);
    this->fileToolBar->addAction(color);
    this->fileToolBar->addAction(dash);
    this->fileToolBar->addAction(dot);
    this->fileToolBar->addWidget(slider);
    this->fileToolBar->addAction(line);
    this->fileToolBar->addAction(circle);
    this->fileToolBar->addAction(rect);
    this->fileToolBar->addAction(deleteOne);
    this->fileToolBar->addAction(deleteAll);

    this->zd = new ZoneDessin();
    this->setCentralWidget(zd);

    connect(open, SIGNAL(triggered()), this, SLOT(openFile()));
    connect(save, SIGNAL(triggered()), this, SLOT(saveFile()));
    connect(quit, SIGNAL(triggered()), qApp, SLOT(quit()));
    connect(color, SIGNAL(triggered()), zd, SLOT(changeColor()));
    connect(dash, SIGNAL(triggered()), zd, SLOT(changeStyle()));
    connect(dot, SIGNAL(triggered()), zd, SLOT(changeStyle()));
    connect(slider, SIGNAL(valueChanged(int)), zd, SLOT(changeWidth(int)));
    connect(line, SIGNAL(triggered()), zd, SLOT(changeForm()));
    connect(circle, SIGNAL(triggered()), zd, SLOT(changeForm()));
    connect(rect, SIGNAL(triggered()), zd, SLOT(changeForm()));
    connect(deleteOne, SIGNAL(triggered()), zd, SLOT(deleteForm()));
    connect(deleteAll, SIGNAL(triggered()), zd, SLOT(deleteForm()));


}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::openFile()
{
    QFileDialog dialog (this);
    dialog.setFilter("Text files (*.txt)");
    QStringList fileNames;

    if (dialog.exec() == QDialog::Accepted)
    {
        fileNames = dialog.selectedFiles();
        QFile file(fileNames[0]);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
            return;

        QTextStream in(&file);
        while (!in.atEnd()) {
            QString line = in.readLine();
            this->textEdit->append(line);
        }
    }
}

void MainWindow::saveFile()
{
    QFileDialog dialog (this);
    dialog.setFilter("Text files (*.txt)");
    QString filename;

    if (dialog.exec() == QDialog::Accepted)
    {
        filename = dialog.getSaveFileName();
        QFile f( filename );
        f.open( QIODevice::WriteOnly );
        QTextStream out(&f);
        out << textEdit->toPlainText();
    }
}
