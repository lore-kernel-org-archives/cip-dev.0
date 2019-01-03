From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 3 Jan 2019 19:03:22 +0100
Subject: [cip-dev] [RFC] isar-cip-core
Message-ID: <f3408484-dd40-ef30-6642-dd18dfe2315a@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

happy new year to everyone!

New year, new project: I've started isar-cip-core in our incubating area, see 
https://gitlab.com/cip-playground/isar-cip-core.

It's currently only generating an SD card image for the BeagleBone Black, but 
that can easily be extended. The idea is to model our generic profile CIP Core 
this way, producing images that contain all supported packages and can then be 
used for testing, evaluation etc.

README is still missing, will write one tomorrow:

# wget https://raw.githubusercontent.com/siemens/kas/master/kas-docker
# chmod a+x kas-docker
# ./kas-docker --isar build kas.yml:board-bbb.yml

or

# ./kas-docker --isar build kas.yml:board-bbb.yml:opt-rt.yml

for the RT variant.

Looking forward to feedback!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
