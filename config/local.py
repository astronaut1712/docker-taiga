# Copyright (C) 2014 Andrey Antukh <niwi@niwi.be>
# Copyright (C) 2014 Jesús Espino <jespinog@gmail.com>
# Copyright (C) 2014 David Barragán <bameda@dbarragan.com>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from .development import *
import os

#ADMINS = (
#    ("Admin", "example@example.com"),
#)

DATABASES = {
    'default': {
        'ENGINE': 'transaction_hooks.backends.postgresql_psycopg2',
        'NAME': os.getenv('TAIGA_DB_NAME') or 'taiga',
        'USER': os.getenv('TAIGA_DB_USER') or 'taiga',
        'PASSWORD': os.getenv('TAIGA_DB_PASSWD') or 'taiga',
        'HOST': os.getenv('TAIGA_DB_HOST') or 'postgres',
        'PORT': os.getenv('TAIGA_DB_PORT') or 5432,
    }
}

TAIGA_HOSTNAME = os.getenv('TAIGA_HOSTNAME')

MEDIA_URL = "http://%s/media/" % TAIGA_HOSTNAME
STATIC_URL = "http://%s/static/" % TAIGA_HOSTNAME
ADMIN_MEDIA_PREFIX = "http://%s/static/admin/" % TAIGA_HOSTNAME
SITES['api']['domain'] = TAIGA_HOSTNAME
SITES['front']['domain'] = TAIGA_HOSTNAME

SECRET_KEY = "theveryultratopsecretkey"

DEBUG = False
TEMPLATE_DEBUG = False
PUBLIC_REGISTER_ENABLED = True

DEFAULT_FROM_EMAIL = "no-reply@%s" % TAIGA_HOSTNAME
SERVER_EMAIL = DEFAULT_FROM_EMAIL
#SITE_ID = "api"

MEDIA_ROOT = '/home/taiga/media'
STATIC_ROOT = '/home/taiga/static'


# EMAIL SETTINGS EXAMPLE
#EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
#EMAIL_USE_TLS = False
#EMAIL_HOST = 'localhost'
#EMAIL_PORT = 25
#EMAIL_HOST_USER = 'user'
#EMAIL_HOST_PASSWORD = 'password'
#DEFAULT_FROM_EMAIL = "john@doe.com"

# GMAIL SETTINGS EXAMPLE
#EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
#EMAIL_USE_TLS = True
#EMAIL_HOST = 'smtp.gmail.com'
#EMAIL_PORT = 587
#EMAIL_HOST_USER = 'youremail@gmail.com'
#EMAIL_HOST_PASSWORD = 'yourpassword'

# THROTTLING
#REST_FRAMEWORK["DEFAULT_THROTTLE_RATES"] = {
#    "anon": "20/min",
#    "user": "200/min",
#    "import-mode": "20/sec",
#    "import-dump-mode": "1/minute"
#}

# GITHUB SETTINGS
#GITHUB_URL = "https://github.com/"
#GITHUB_API_URL = "https://api.github.com/"
#GITHUB_API_CLIENT_ID = "yourgithubclientid"
#GITHUB_API_CLIENT_SECRET = "yourgithubclientsecret"

# FEEDBACK MODULE (See config in taiga-front too)
#FEEDBACK_ENABLED = True
#FEEDBACK_EMAIL = "support@taiga.io"

# STATS MODULE
#STATS_ENABLED = False
#FRONT_SITEMAP_CACHE_TIMEOUT = 60*60  # In second

# SITEMAP
# If is True /front/sitemap.xml show a valid sitemap of taiga-front client
#FRONT_SITEMAP_ENABLED = False
#FRONT_SITEMAP_CACHE_TIMEOUT = 24*60*60  # In second
