From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Wed, 14 Feb 2018 14:04:13 +0100
Subject: [cip-dev] [test issue #99] Issues with installing when running
	behind a web proxy
Message-ID: <CAEss1E+4z6r9=UhnMxnh_Pco=i_usk3Pn05tb=q8h1t0CjV_Dg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

https://gitlab.com/cip-project/cip-testing/testing/issues/99

Also from:
https://lists.cip-project.org/pipermail/cip-dev/2017-July/000338.html

At the end of test issue #99, I added the solution to this problem.

Lava does NOT read VM's ENV variables. It ignores them. Lava reads
/etc/lava-server/env.yaml as setup proxy file!

Included there also /etc/lava-server/env.yaml file example.

It could be done also DIRECTLY (every time bringing up the VM) using
python, tapping into the urllib3 python code (example given):
https://stackoverflow.com/questions/31151615/how-to-handle-proxies-in-urllib3

I've tried this, using in-line python interpreter, it worked.

Zoran
