#ifndef HOTRELOAD_H
#define HOTRELOAD_H

#include <QPointer>
#include <QQmlApplicationEngine>

class HotReload : public QObject
{
Q_OBJECT
    public slots:
    Q_INVOKABLE void clearCache()
    {
        m_engine->clearComponentCache();
    }

 public:
    HotReload(QQmlApplicationEngine *engine) : m_engine(engine) {}

private:
    QPointer<QQmlApplicationEngine> m_engine;

};

#endif // HOTRELOAD_H
