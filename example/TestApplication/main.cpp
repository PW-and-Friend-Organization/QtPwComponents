#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlPropertyMap>
#include <QColor>
#include <QZXing.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QZXing::registerQMLTypes();

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/");

    // create property for PwComponentTheme
    QQmlPropertyMap themeColor;
    themeColor.insert("primaryColor", QVariant(QColor("#3F51B5")));
    themeColor.insert("backgroudColorLight", QVariant(QColor("#F1F2F6")));
    themeColor.insert("backgroudColorShade", QVariant(QColor("#CED6E0")));
    themeColor.insert("foregroundColor", QVariant(QColor("#000")));
    themeColor.insert("inverseForegroundColor", QVariant(QColor("#FFF")));
    engine.rootContext()->setContextProperty("themeColor", &themeColor);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
