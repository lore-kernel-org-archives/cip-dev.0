From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 30 May 2018 17:41:11 +0100
Subject: [cip-dev] [PATCH 57/62] thermal: rcar: enable to use
	thermal-zone on DT
In-Reply-To: <OSBPR01MB21036D9A72AC74C2F5EB2A23B86C0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
	<1525964931-14960-58-git-send-email-biju.das@bp.renesas.com>
	<1526065917.6671.30.camel@codethink.co.uk>
	<OSBPR01MB21031EC0D28B91DAFEF38990B8950@OSBPR01MB2103.jpnprd01.prod.outlook.com>
	<1527694144.2289.10.camel@codethink.co.uk>
	<OSBPR01MB21036D9A72AC74C2F5EB2A23B86C0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <1527698471.2289.19.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2018-05-30 at 16:34 +0000, Biju Das wrote:
[...]
> > > ?Are you ok for backporting the above patch? If yes, then it make sense to
> > > backport the commits 5e325868aa59 and d4b23c5c434a.
> > 
> > Yes, I think this is OK.??Commit e498b4984 doesn't change any existing
> > functions so it should be safe to add.
> 
> Shall I send only thermal related patches??or do you want me to send V2 with 65 patches?
> Please let me know.

I saved that patch series, so please just let me know what needs to be
added or replaced.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
We respect your privacy.?? See https://www.codethink.co.uk/privacy.html
