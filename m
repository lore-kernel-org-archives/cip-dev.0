From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Mon, 20 Jan 2020 14:24:02 +0000
Subject: [cip-dev] RFC: Python version of CIP's maintenance target
Message-ID: <TYXPR01MB18086C7A61AAF2AE96E8E570E1320@TYXPR01MB1808.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

Python 2.x has become EOL on January 1st.
In Debian 10 buster (and older versions), there are many packages that depend on python 2.7.
e.g. https://packages.debian.org/buster/trace-cmd

When CIP wants to support some packages that depend on python 2.7,
though there has not been such packages are proposed to CIP Core yet,
should we keep these dependencies on 2.7 or replace them?

There are several options to replace these dependencies:

* Replace the package that depends on 2.7 by newer packages that depends on python 3
  e.g. Use a package in buster-backports
* Modify the package (create CIP custom package) to replace the dependency on 2.7 by 3
...

However, adding unnecessary changes to the existing Debian packages should be avoided.
Also, package versions included in Debian stable release (or older releases) are
basically fixed, so there is not so much concern about using python 2.7 packages
provided (and maintained) in Debian / Debian (E)LTS.

Any thoughts?

Best regards,
Kazu
