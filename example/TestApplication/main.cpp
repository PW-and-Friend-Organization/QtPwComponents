#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlPropertyMap>
#include <QColor>
#include <QZXing.h>
#include "hotreload.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QZXing::registerQMLTypes();

    QQmlApplicationEngine engine;
    HotReload hotReload(&engine);
    engine.addImportPath("qrc:/");

    // expose C++ classes to QML
    engine.rootContext()->setContextProperty("__hotReload", &hotReload);

    // create property for PwComponentTheme
    QQmlPropertyMap themeColor;
    themeColor.insert("primaryColor", QVariant(QColor("#3F51B5")));
    themeColor.insert("backgroudColorLight", QVariant(QColor("#F1F2F6")));
    themeColor.insert("backgroudColorShade", QVariant(QColor("#CED6E0")));
    themeColor.insert("foregroundColor", QVariant(QColor("#000")));
    themeColor.insert("inverseForegroundColor", QVariant(QColor("#FFF")));
    engine.rootContext()->setContextProperty("themeColor", &themeColor);

    engine.load(QUrl(QLatin1String("qrc:/loader.qml")));

#ifdef QT_DEBUG
    engine.rootObjects().first()->setProperty("__debug", true);
#else
    engine.rootObjects().first()->setProperty("__debug", false);
#endif

    return app.exec();
}
