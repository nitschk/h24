using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace h24
{
    public static class SettingsManager
    {
        private static Dictionary<string, string> _settingsCache;

        static SettingsManager()
        {
            _settingsCache = new Dictionary<string, string>();
            LoadSettings();
        }

        private static void LoadSettings()
        {
            using (var db = new klc01())
            {
                var settings = db.settings.ToList();
                foreach (var setting in settings)
                {
                    _settingsCache[setting.config_name] = setting.config_value;
                }
            }
        }

        public static string GetSetting(string key)
        {
            if (_settingsCache.ContainsKey(key))
            {
                return _settingsCache[key];
            }
            return ""; // Or throw an exception, depending on your needs
        }
    }

}
