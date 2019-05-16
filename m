From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Thu, 16 May 2019 00:44:11 +0000
Subject: [cip-dev] MDS and other speculation issues
In-Reply-To: <1557920010.3952.2.camel@codethink.co.uk>
References: <1557920010.3952.2.camel@codethink.co.uk>
Message-ID: <TYAPR01MB41891550E349BF4F04888203920A0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Ben
> Hutchings
> Sent: Wednesday, May 15, 2019 8:34 PM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] MDS and other speculation issues
> 
> As with the earlier speculation vulnerabilities, I don't believe that
> MDS should be a particularly severe issue for CIP-based systems.
> 
> Nevertheless, I have prepared a backport of the mitigations for MDS (and
> some changes to the mitigations for other speculation issues) for 4.4.
> This was included in 4.4.180-rc1, which is out for review now.  I did
> not have the chance to test this thoroughly, so review and testing are
> needed.

Thank you for your work and information.
I'm just looking into a test tool for this issue, but please let me know what
you already know.

There is a spectre-meltdown-checker, but we can not do a detailed test with this.
https://github.com/speed47/spectre-meltdown-checker/

> 
> Ben.
> 
Best regards,
  Nobuhirio
