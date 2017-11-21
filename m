From: sean_hudson@mentor.com (Sean Hudson)
Date: Tue, 21 Nov 2017 10:22:02 -0600
Subject: [cip-dev] RFC: OpenEmbedded layer for CIP project
In-Reply-To: <TY1PR06MB070264F4A150D9E2684C5AECB7540@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <3c6721a5baf6437ba3a35c3c45a8b20b@svr-orw-mbx-01.mgc.mentorg.com>
	<TY1PR06MB070264F4A150D9E2684C5AECB7540@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <a51472da-6c11-cdea-db32-ceb3884f70a3@mentor.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-11-10 06:10 AM, Chris Paterson wrote:
> Hello Sean,
> 
>> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-
>> bounces at lists.cip-project.org] On Behalf Of Hudson, Sean
>> Sent: 19 September 2017 16:46
>>
>> Hey all,
>>
>>   I'm still new to the project and working my way through the email archives.
>> However, I've started creating a meta-cip layer to capture metadata for
>> building the CIP project with OpenEmbedded.  This will allow it to build with
>> the Yocto Project, as well.  I'll create a project on gitlab soon to start collecting
>> my changes.
>>
>>   Any comments, concerns or thoughts?
> 
> Following on from our conversations at ELC-E I wanted to reboot this
> thread.
> 
> Have you had a chance to look into this topic again? Did you create
> the gitlab project in the end?
  I have not looked at it since I returned. I plan to start looking at
this again next week, after the US Thanksgiving holiday.  WRT to a
gitlab project, I do not have rights to create a project under the
cip-project, but it looks like Daniel created a cip-core project a few
days back, which is, at least currently, Deby focused.

> 
> What were you aiming to include in your meta-cip layer?

That's the million dollar question, IMHO.  I am thinking we start with
the usual basic components and add from there:
- kernel
- libc of some form
- shell and command line utilities, e.g. busybox/toybox
- init flavor, most likely systemd at this point
- ...

Bootloaders may be problematic as they are more intimately tied to
specific architectures.  So any selection there would need to be
considered carefully.

So, let me turn the question around, what's do companies think they will
need?

Another additional consideration for package selection would be the
licenses.  It seems like most companies are 'allergic' to GPLv3, so we
should factor that into the package selections.

-- 
Sean

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20171121/cc2f57db/attachment.sig>
