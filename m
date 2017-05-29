From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 29 May 2017 07:36:45 +0200
Subject: [cip-dev] Kernel feature support - filesystems and networking
In-Reply-To: <390B4EACA1A32748BA6BC7F859F7D71656BF302D@GSjpTKYDCembx32.service.hitachi.net>
References: <1496023981.2083.43.camel@codethink.co.uk>
	<390B4EACA1A32748BA6BC7F859F7D71656BF302D@GSjpTKYDCembx32.service.hitachi.net>
Message-ID: <f47f352b-ce48-3e68-3bde-8c264d0a7512@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-05-29 04:40, ???? / KOGUCHI?TAKUO wrote:
> Hi Ben,
> 
> Thanks for your efforts.
> 
>> - overlayfs (CONFIG_OVERLAY_FS)
> OVERLAY_FS is one of the features Hitachi wants to use.
> I hope you look into this further and I would like to know if other members also want it.
> 

We plan to use this feature with CIP kernels as well.

Regards,
Jan

> Best regards,  
> 
> Takuo Koguchi,
> Hitachi, Ltd.
> 
> 
>> -----Original Message-----
>> From: cip-dev-bounces at lists.cip-project.org
>> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Ben Hutchings
>> Sent: Monday, May 29, 2017 11:13 AM
>> To: cip-dev at lists.cip-project.org
>> Subject: [!][cip-dev] Kernel feature support - filesystems and networking
>>
>> I apologise for the long delay in responding to the kernel config files I was given.  Here's a
>> first list of features I would like to *not* support.  I expect to be able to send additional lists
>> soon.  Let me know if you really need some of the features listed below, and if you have
>> any ideas about how to mitigate the problems I see.
>>
>> The following features are enabled in some of the configurations I was sent but seem to
>> be unsupportable over CIP's time scale:
>>
>> File systems:
>> - btrfs (CONFIG_BTRFS_FS)
>>   - Too rapidly changing to backport most fixes
>> - ceph (CONFIG_CEPH_LIB, CONFIG_CEPH_FS)
>>   - Complex network protocol which is likely to need many fixes
>> - cifs (CONFIG_CIFS_FS)
>>   - Complex network protocol which is likely to need many fixes
>> - nfs (CONFIG_NFS_FS, CONFIG_NFSD)
>>   - Complex network protocol which is likely to need many fixes
>> - ufs (CONFIG_UFS_FS)
>>   - No work by current maintainer for 7 years
>> - xfs (CONFIG_XFS_FS)
>>   - Maintainers unsupportive of backporting fixes
>>
>> Networking:
>> - batman-adv (CONFIG_BATMAN_ADV)
>>   - Rapidly changing
>> - caif (CONFIG_CAIF)
>>   - No work by current maintainer for 5 years
>> - dcb (CONFIG_DCB)
>>   - No current maintainer
>> - hsr (CONFIG_HSR)
>>   - No work by current maintainer for 2 years
>> - llc2 (CONFIG_LLC2)
>>   - No work by current maintainer for 7 years
>> - phonet (CONFIG_PHONET)
>>   - Dead protocol
>> - sctp (CONFIG_IP_SCTP)
>>   - Poor security record
>> - wimax (CONFIG_WIMAX)
>>   - Dead protocol
>> - x25 (CONFIG_X25)
>>   - Poor security record
>>
>> I have some doubts about whether these can be supported:
>>
>> - ntfs (CONFIG_NTFS_FS)
>>   - Fixes are never marked for stable
>> - overlayfs (CONFIG_OVERLAY_FS)
>>   - I found many apparently important bug fixes in later kernel
>>     versions that have not been backported
>>
>> Ben.
>>
>> --
>> Ben Hutchings
>> Software Developer, Codethink Ltd.
>>
>>
>> _______________________________________________
>> cip-dev mailing list
>> cip-dev at lists.cip-project.org
>> https://lists.cip-project.org/mailman/listinfo/cip-dev
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
> 
