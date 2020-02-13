From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 13 Feb 2020 12:37:37 +0000
Subject: [cip-dev] Creating own LAVA lab
In-Reply-To: <CADPJy8XaMYUd+m8bxkZW7FezFjjLAcOFme+J2ifVF-sYa_ssDQ@mail.gmail.com>
References: <CADPJy8XaMYUd+m8bxkZW7FezFjjLAcOFme+J2ifVF-sYa_ssDQ@mail.gmail.com>
Message-ID: <TYAPR01MB2285933134207F423A7F9767B71A0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Toyooka-san,

> From: hiraku.toyooka at cybertrust.co.jp <hiraku.toyooka@cybertrust.co.jp>
> Sent: 12 February 2020 06:54
> 
> Hello Chris,
> 
> I'm creating Cybertrust's own LAVA lab discussed at [1] to
> integrate zcu102 board to CIP kernel testing pipeline, while

Huzzah!

> referring to [2]. At this time, health check for the zcu102 board
> is working with PDU.
> Could you make an account for me with lava.ciplatform.org?

Sure. I'll email you the details privately.

> 
> [1] https://lists.cip-project.org/pipermail/cip-dev/2019-
> September/003341.html
> [2] https://gitlab.com/cip-project/cip-testing/lava-docker/-/blob/cip-lava-
> docker/documentation/setup_cip_lava_lab.md#prerequisites
> 
> I think the following information is also necessary to obtain the
> public master key. Should I send the items to you directly?

Yes please.

> 
> - name of my lab/worker
> - the dispatcher IP of the lab
> - the lab's public key (as a file)
> 
> Please let me know if any other information is necessary.

You'll need to create device-type and healthcheck templates for your board and submit a MR for them to our lava-docker repo.

Kind regards, Chris

> 
> Best regards,
> --
> Hiraku Toyooka
> Cybertrust Japan Co., Ltd.
