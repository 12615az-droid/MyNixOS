# Подключай через `imports = [ ./firefox-purple.nix ];` в Home Manager.
# NixOS + Home Manager / KDE Plasma / Firefox Purple Neon.
{ ... }:

{
  programs.firefox = {
    enable = true;

    # Интерфейс Firefox на русском (не просто язык сайтов).
    languagePacks = [ "ru" ];

    profiles.default = {
      # Используем существующий профиль, чтобы сохранить аккаунты, cookies и историю.
      id = 0;
      isDefault = true;
      path = "6o792e29.default";


      settings = {
        # Русский язык интерфейса и предпочтительный язык сайтов.
        "intl.locale.requested" = "ru";
        "intl.accept_languages" = "ru-RU,ru,en-US,en";

        # Темный интерфейс и темное оформление на сайтах,
        # которые поддерживают prefers-color-scheme.
        "ui.systemUsesDarkTheme" = 1;
        "layout.css.prefers-color-scheme.content-override" = 0;

        # Позволяет использовать userChrome.css и userContent.css.
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # При запуске открывать домашнюю страницу Firefox.
        "browser.startup.page" = 1;
        "browser.startup.homepage" = "about:home";
        "browser.newtabpage.enabled" = true;

        # Показывать закрепленные ярлыки на новой вкладке.
        "browser.newtabpage.activity-stream.feeds.topsites" = true;
        "browser.newtabpage.activity-stream.topSitesRows" = 1;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;

        "browser.newtabpage.pinned" = [
          { url = "https://my.weasel.cloud/clientarea.php"; title = "WeaselCloud"; }
          { url = "https://www.youtube.com/"; title = "YouTube"; }
          { url = "https://github.com/12615az-droid"; title = "GitHub"; }
          { url = "https://deepstatemap.live/"; title = "DeepState"; }
          { url = "https://liveuamap.com/ru"; title = "Liveuamap"; }
          { url = "https://stats.deadbydaylight.com/statistics/"; title = "DBD Stats"; }
        ];
      };

      # Оформление самого Firefox: вкладки, верхняя панель,
      # адресная строка, меню и боковая панель.
      userChrome = ''
        :root {
          color-scheme: dark !important;
          --lwt-accent-color: #111019 !important;
          --lwt-text-color: #eadeff !important;
          --toolbar-bgcolor: #22182f !important;
          --toolbar-color: #eee7ff !important;
          --toolbar-field-background-color: #17121f !important;
          --toolbar-field-color: #f0e9ff !important;
          --toolbar-field-border-color: #64428e !important;
          --toolbar-field-focus-background-color: #20162e !important;
          --toolbar-field-focus-color: #ffffff !important;
          --tab-selected-bgcolor: #57327a !important;
          --focus-outline-color: #a970ed !important;
          --button-hover-bgcolor: #3a2850 !important;
          --button-active-bgcolor: #57327a !important;
          --arrowpanel-background: #22182f !important;
          --arrowpanel-color: #eee7ff !important;
          --arrowpanel-border-color: #64428e !important;
        }

        #navigator-toolbox {
          background: #111019 !important;
          border-bottom: 1px solid #523576 !important;
        }

        #TabsToolbar {
          background: #111019 !important;
        }

        #nav-bar, #PersonalToolbar {
          background: #22182f !important;
          box-shadow: none !important;
        }

        .tabbrowser-tab .tab-background {
          border-radius: 10px 10px 5px 5px !important;
          margin-block: 3px 0 !important;
        }

        .tabbrowser-tab[selected] .tab-background {
          background: #57327a !important;
          box-shadow: inset 0 -2px 0 #20c4e8 !important;
        }

        .tabbrowser-tab:hover:not([selected]) .tab-background {
          background: #2e203e !important;
        }

        #urlbar-background, #searchbar {
          background: #17121f !important;
          border: 1px solid #64428e !important;
          border-radius: 12px !important;
          box-shadow: none !important;
        }

        #urlbar[focused] #urlbar-background {
          border-color: #a970ed !important;
          box-shadow: 0 0 0 1px #a970ed !important;
        }

        #sidebar-box, #sidebar-header {
          background: #17121f !important;
          color: #eee7ff !important;
        }

        toolbarbutton:hover > .toolbarbutton-icon,
        toolbarbutton:hover > .toolbarbutton-badge-stack {
          border-radius: 9px !important;
        }
      '';

      # Оформление домашней страницы и новой вкладки Firefox.
      userContent = ''
        @-moz-document url("about:newtab"), url("about:home") {
          body {
            --newtab-background-color: #111019 !important;
            --newtab-background-color-secondary: #22182f !important;
            --newtab-text-primary-color: #eee7ff !important;
            --newtab-primary-action-background: #a970ed !important;
            background: radial-gradient(
              circle at 50% 0%,
              #39234d 0%,
              #181221 42%,
              #111019 78%
            ) !important;
            color: #eee7ff !important;
          }

          .top-site-outer .tile {
            background: #271a38 !important;
            border: 1px solid #624086 !important;
            border-radius: 16px !important;
            box-shadow: 0 3px 16px #09070d88 !important;
          }

          .top-site-outer:hover .tile {
            background: #392451 !important;
            border-color: #a970ed !important;
            box-shadow: 0 0 12px #a970ed55 !important;
          }

          .top-site-outer .title span,
          .section-title span {
            color: #eee7ff !important;
          }

          .search-handoff-button {
            background: #22182f !important;
            color: #eee7ff !important;
            border: 1px solid #674390 !important;
            border-radius: 14px !important;
            box-shadow: 0 0 0 1px #20c4e822 !important;
          }

          .search-handoff-button:hover {
            border-color: #a970ed !important;
          }
        }
      '';
    };
  };
}
