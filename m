From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 29 May 2017 04:58:30 +0100
Subject: [cip-dev] Kernel feature support - filesystems and networking
In-Reply-To: <390B4EACA1A32748BA6BC7F859F7D71656BF302D@GSjpTKYDCembx32.service.hitachi.net>
References: <1496023981.2083.43.camel@codethink.co.uk>
	<390B4EACA1A32748BA6BC7F859F7D71656BF302D@GSjpTKYDCembx32.service.hitachi.net>
Message-ID: <592B9C66.709@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

On 29/05/17 03:40, ???? / KOGUCHI?TAKUO wrote:
> Hi Ben,
>
> Thanks for your efforts.
>
>> - overlayfs (CONFIG_OVERLAY_FS)
 >>   - I found many apparently important bug fixes in later kernel
     versions that have not been backported

Is there a technical reason for these patches not being backported or is 
it simply that never was requested/needed before?

> OVERLAY_FS is one of the features Hitachi wants to use.
> I hope you look into this further and I would like to know if other members also want it.

Based on this request, is it possible for you to estimate the effort to 
do this?

@Takuo is there a kernel developer from Hitachi that would be willing to 
work under Ben's supervision/review in backporting these patches?

Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
