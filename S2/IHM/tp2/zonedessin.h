#ifndef ZONEDESSIN_H
#define ZONEDESSIN_H

#include <iostream>
#include <typeinfo>
#include <QWidget>
#include <QMouseEvent>
#include <QPainter>
#include <QPen>
#include <QColorDialog>

using namespace std;

class ZoneDessin : public QWidget
{
    Q_OBJECT

public:
    explicit ZoneDessin();
    ~ZoneDessin();

private:
    QPoint depart;
    QPoint arrivee;
    QPoint milieu;
    QPen pen;
    string shape;
    bool dessine;

    vector<string> shapes;
    vector<pair<QLine*,QPen> > lignes;
    vector<pair<QRect*,QPen> > rectangles;
    vector<pair<QRect*,QPen> > cercles;

protected:
    void paintEvent(QPaintEvent* e);
    void mousePressEvent(QMouseEvent* e);
    void mouseReleaseEvent(QMouseEvent* e);
    void mouseMoveEvent(QMouseEvent *e);

public slots:
    void changeColor();
    void changeWidth(int width);
    void changeStyle();
    void changeForm();
    void deleteForm();
};
#endif // ZONEDESSIN_H
