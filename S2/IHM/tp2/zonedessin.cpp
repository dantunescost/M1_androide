#include "zonedessin.h"


ZoneDessin::ZoneDessin() : QWidget()
{
    this->shape = "line";
    this->setMinimumSize(500,300);
}

ZoneDessin::~ZoneDessin(){}

void ZoneDessin::paintEvent(QPaintEvent *e)
{
    QWidget::paintEvent(e);
    QPalette Pal(palette());
    Pal.setColor(QPalette::Background, Qt::white);
    this->setAutoFillBackground(true);
    this->setPalette(Pal);
    int nbL=0, nbC=0, nbR=0;
    for(int i=0;i<this->shapes.size();i++){
        QPainter painter(this);
        painter.setRenderHint( QPainter::Antialiasing );
        this->pen.setCapStyle(Qt::RoundCap);
        if(this->shapes[i]=="line"){
            painter.setPen(this->lignes[nbL].second);
            painter.drawLine((QLine)*(this->lignes[nbL].first));
            nbL++;
        }
        else if(this->shapes[i]=="rect"){
            painter.setPen(this->rectangles[nbR].second);
            painter.drawRect((QRect)*(this->rectangles[nbR].first));
            nbR++;
        }
        else if(this->shapes[i]=="circle"){
            painter.setPen(this->cercles[nbC].second);
            painter.drawArc((QRect)*(this->cercles[nbC].first),0,360*16);
            nbC++;
        }

    }
    if(this->dessine){
        QPainter painter(this);
        painter.setRenderHint( QPainter::Antialiasing );
        this->pen.setCapStyle(Qt::RoundCap);
        painter.setPen(this->pen);
        if(this->shape=="line"){
            painter.drawLine(depart,milieu);
        }
        else{
            int d,a,w,h;
            if(depart.rx() < milieu.rx()){
                d = depart.rx();
                w = milieu.rx() - depart.rx();
            }
            else{
                d = milieu.rx();
                w = depart.rx() - milieu.rx();
            }
            if(depart.ry() < milieu.ry()){
                a = depart.ry();
                h = milieu.ry() - depart.ry();
            }
            else{
                a = milieu.ry();
                h = depart.ry() - milieu.ry();
            }
            if(this->shape=="rect"){
                painter.drawRect(d,a,w,h);
            }
            else{
                painter.drawArc(d,a,w,h,0,360*16);
            }
        }
    }
}

void ZoneDessin::mousePressEvent(QMouseEvent* e)
{
    this->depart = e->pos();
    this->dessine = true;
}

void ZoneDessin::mouseMoveEvent(QMouseEvent *e)
{
    this->milieu = e->pos();
    update();
}

void ZoneDessin::mouseReleaseEvent(QMouseEvent* e)
{
    this->arrivee = e->pos();
    this->shapes.push_back(this->shape);
    if(this->shape=="line"){
        QLine* line = new QLine(this->depart,this->arrivee);
        pair<QLine*,QPen> tuple(line,this->pen);
        this->lignes.push_back(tuple);
    }
    else if(this->shape=="rect"){
        int d,a,w,h;
        if(depart.rx() < arrivee.rx()){
            d = depart.rx();
            w = arrivee.rx() - depart.rx();
        }
        else{
            d = arrivee.rx();
            w = depart.rx() - arrivee.rx();
        }
        if(depart.ry() < arrivee.ry()){
            a = depart.ry();
            h = arrivee.ry() - depart.ry();
        }
        else{
            a = arrivee.ry();
            h = depart.ry() - arrivee.ry();
        }
        QRect* rect = new QRect(d,a,w,h);
        pair<QRect*,QPen> tuple(rect,this->pen);
        this->rectangles.push_back(tuple);
    }
    else if(this->shape=="circle"){
        int d,a,w,h;
        if(depart.rx() < arrivee.rx()){
            d = depart.rx();
            w = arrivee.rx() - depart.rx();
        }
        else{
            d = arrivee.rx();
            w = depart.rx() - arrivee.rx();
        }
        if(depart.ry() < arrivee.ry()){
            a = depart.ry();
            h = arrivee.ry() - depart.ry();
        }
        else{
            a = arrivee.ry();
            h = depart.ry() - arrivee.ry();
        }
        QRect* rect = new QRect(d,a,w,h);
        pair<QRect*,QPen> tuple(rect,this->pen);
        this->cercles.push_back(tuple);
    }
    this->dessine = false;
    update();
}

void ZoneDessin::changeColor()
{
    QColor color = QColorDialog::getColor(Qt::black, this, "Pen Color",  QColorDialog::DontUseNativeDialog);
    if(color.isValid())
    {
        this->pen.setColor(color);
    }
}

void ZoneDessin::changeWidth(int width)
{
    this->pen.setWidth(width);
}

void ZoneDessin::changeStyle()
{
    if(sender()->objectName() == "dot")
    {
        this->pen.setStyle(Qt::DotLine);
    }
    else{
        this->pen.setStyle(Qt::DashLine);
    }
}

void ZoneDessin::changeForm()
{
    if(sender()->objectName() == "circle"){
        this->shape = "circle";
    }
    else if(sender()->objectName() == "rect"){
        this->shape = "rect";
    }
    else if(sender()->objectName() == "line"){
        this->shape = "line";
    }
}

void ZoneDessin::deleteForm()
{
    if(sender()->objectName() == "del1"){
        if(this->shapes.size()!=0){
            if(this->shapes.back() == "line"){
                if(this->lignes.size()!=0)
                    this->lignes.pop_back();
            }
            else if(this->shapes.back() == "rect"){
                if(this->rectangles.size()!=0)
                    this->rectangles.pop_back();
            }
            else if(this->shapes.back() == "circle"){
                if(this->cercles.size()!=0)
                    this->cercles.pop_back();
            }
            this->shapes.pop_back();
        }
    }
    else{
        this->shapes.clear();
        this->lignes.clear();
        this->rectangles.clear();
        this->cercles.clear();
    }
    update();
}
