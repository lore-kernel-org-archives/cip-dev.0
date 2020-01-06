From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Mon, 6 Jan 2020 00:39:35 +0000
Subject: [cip-dev] Getting older -cip-rebase versions
In-Reply-To: <20191229172557.GA18039@duo.ucw.cz>
References: <20191229172557.GA18039@duo.ucw.cz>
Message-ID: <OSAPR01MB3667987C41E9C68D6D0F5D6E923C0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> -----Original Message-----
> From: cip-dev [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf
> Of Pavel Machek
> Sent: Monday, December 30, 2019 2:26 AM
> To: iwamatsu at nigauri.org; cip-dev at lists.cip-project.org
> Subject: [cip-dev] Getting older -cip-rebase versions
> 
> Hi!
> 
> To prepare -cip-rt-rebase, I'd like to start with -cip-rebase. That seems
> to be easy with latest version, but not with the older ones:
> 
> pavel at duo:~/cip/k$ git show v4.19.91-cip17-rebase tag
> v4.19.91-cip17-rebase commit 0c809da57d1f66315f0d75cab818cf1121ba652c
> (tag: v4.19.91-cip17-rebase, origin/linux-4.19.y-cip-rebase)
> Author: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Date:   Sat Dec 28 05:55:06 2019 +0900
> 
>     CIP: Bump version suffix to -cip17 after merge from stable
> 
> pavel at duo:~/cip/k$ git show v4.19.88-cip16-rebase
> fatal: ambiguous argument 'v4.19.88-cip16-rebase': unknown revision or
> path not in the working tree.
> 
> Is there way to get to that version? Would it be possible to keep those
> tags in future?

Please use 'git fetch --tags' .
With git normal commands, you can only get tags that are reachable from the branch.
In this case, execute as above.

Best regards,
  Nobuhiro
