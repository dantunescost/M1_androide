#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    //ui->setupUi(this);
    this->statusBar();

    this->fmenuBar = menuBar();
    this->file = fmenuBar->addMenu(tr("&File"));

    this->open = new QAction(QIcon(":/images/open.png"),tr("&Open..."), this);
    this->save = new QAction(QIcon(":/images/save.png"),tr("&Save..."), this);
    this->quit = new QAction(QIcon(":/images/quit.png"),tr("&Quit..."), this);

    open->setStatusTip(tr("Open file"));
    save->setStatusTip(tr("Save file"));
    quit->setStatusTip(tr("Quit"));

    file->addAction(open);
    file->addAction(save);
    file->addAction(quit);

    this->fileToolBar = addToolBar(tr("File"));
    this->fileToolBar->addAction(open);
    this->fileToolBar->addAction(save);
    this->fileToolBar->addAction(quit);

    this->textEdit = new QTextEdit( this );
    setCentralWidget( textEdit );

    connect(open, SIGNAL(triggered()), this, SLOT(openFile()));
    connect(save, SIGNAL(triggered()), this, SLOT(saveFile()));
    connect(quit, SIGNAL(triggered()), qApp, SLOT(quit()));
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
