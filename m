From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 2 Mar 2018 18:52:19 +0100
Subject: [cip-dev] Meltdown and Spectre in CIP
In-Reply-To: <1518695091.3422.24.camel@codethink.co.uk>
References: <1515593818.12097.10.camel@codethink.co.uk>
	<TY1PR06MB07021E0DE8BDB329DFC8A32FB7EA0@TY1PR06MB0702.apcprd06.prod.outlook.com>
	<1518695091.3422.24.camel@codethink.co.uk>
Message-ID: <32855182-84ed-f190-d5b8-b5c166a4749c@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2018-02-15 12:44, Ben Hutchings wrote:
> [...]
>> Will you be keeping an eye on Spectre patches on behalf of CIP as
>> part of your maintainer role? I guess you may be in the loop a bit
>> more than the rest of us?
> 
> I will look at the mitigations as they land upstream, but I still think
> these are low priority security issues for CIP.

The priority starts to rise here because new system are coming out that
need to start system testing and other processes on a CIP kernel with
Spectre mitigations (x86 so far). Can you estimate the time needed for a
cip19 release?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
