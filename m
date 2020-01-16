From: wagi@monom.org (Daniel Wagner)
Date: Thu, 16 Jan 2020 10:24:16 +0100
Subject: [cip-dev] RT Testing
In-Reply-To: <TYXPR01MB18081C565B8B2F072CC2C9E5E1360@TYXPR01MB1808.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <TYXPR01MB18081C565B8B2F072CC2C9E5E1360@TYXPR01MB1808.jpnprd01.prod.outlook.com>
Message-ID: <d981a938-bcbf-b187-6389-a3c345e52161@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On Thu, Jan 16, 2020 at 06:54:54AM +0000, 
kazuhiro3.hayashi at toshiba.co.jp wrote:
> BTW, it would be better to confirm which Python version (2.7 or 3) that cyclictest.sh depends on.
> Do you know anything about this?

cyclictest.sh uses automated/lib/parse_rt_tests_results.py to parse
the results. The python code runs with either Python2 or Python3

$ python3 -m py_compile  ./automated/lib/parse_rt_tests_results.py
$ python2 -m py_compile  ./automated/lib/parse_rt_tests_results.py

Thanks,
Daniel
