#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>

#include "RegistrationHandler.hpp"
#include "InviteToDownload.hpp"

namespace bb
{
    namespace cascades
    {
        class Application;
        class LocaleHandler;
    }
}

class QTranslator;

/*!
 * @brief Application object
 *
 *
 */

class ApplicationUI : public QObject
{
    Q_OBJECT
public:
    ApplicationUI(bb::cascades::Application *app);
    virtual ~ApplicationUI() { }
    Q_INVOKABLE QString getValueFor(const QString &objectName, const QString &defaultValue);
	Q_INVOKABLE void saveValueFor(const QString &objectName, const QString &inputValue);
private slots:
    void onSystemLanguageChanged();
private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;

	RegistrationHandler *registrationHandler;
	InviteToDownload *inviteToDownload;
};

#endif /* ApplicationUI_HPP_ */
