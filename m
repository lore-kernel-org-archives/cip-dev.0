From: hidehiro.kawai.ez@hitachi.com (=?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=)
Date: Mon, 21 Aug 2017 07:46:30 +0000
Subject: [cip-dev] Kernel feature support - architecture options and
 drivers
In-Reply-To: <1503063539.2047.90.camel@codethink.co.uk>
References: <1500643130.12197.123.camel@codethink.co.uk>
	<04EAB7311EE43145B2D3536183D1A8445B96609D@GSjpTKYDCembx31.service.hitachi.net>
	<1503063539.2047.90.camel@codethink.co.uk>
Message-ID: <04EAB7311EE43145B2D3536183D1A8445B9A0441@GSjpTKYDCembx31.service.hitachi.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben and folks,

> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: Friday, August 18, 2017 10:39 PM
> On Fri, 2017-07-28 at 04:49 +0000, ???? / KAWAI?HIDEHIRO wrote:

> > By the way, I think that `supporting a feature' is not the same as
> > `enabling a feature'.  Does `please disable it' mean that this is a
> > suggestion for a secure config, or imply that CIP shouldn't support
> > this feature?
> 
> Where I said 'please disable it' with no qualification, I think the
> feature is inherently insecure and I don't think CIP should pretend to
> provide security support for it.
> 
> Where I said something like 'check whether you can disable it', I
> consider the feature to be high risk, but CIP should try to support it
> if members need it.

Let me clarify the level of support.  I think there are multiple
support levels:

(1) Backporting security fix
(2) Backporting other bug fix
(3) Backporting additional functionality related to the feature
(4) Answering questions, trouble shooting, ... (should be done by
    community)

If CIP only supports (1), your opinion is reasonable.
If CIP also supports (2), supporting even insecure features will make
sense.  For example, if we want to use a debugging feature which has a
security risk during the development phase, we hope that we can use it
without hitting bugs.

However, I'm not sure which support levels should be supported by CIP.
Have we defined it clearly?  If so, I'm sorry.

Best regards,

--
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
