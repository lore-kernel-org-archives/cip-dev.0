From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 9 Aug 2019 07:04:23 +0200
Subject: [cip-dev] [PATCH linux-4.19.y-cip-rt] staging: m57621-mmc:
 delete driver from the tree.
In-Reply-To: <20190808215338.GA12892@amd>
References: <bff48726-afc7-0676-b189-dad8ca1d559a@siemens.com>
	<20190808215338.GA12892@amd>
Message-ID: <2c22f3ce-300a-34c3-37ff-571e64a029df@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 08.08.19 23:53, Pavel Machek wrote:
> Hi!
> 
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> The license text in this driver is "interesting" and not really obvious
>> that it is supposed to be able to be distributed in the kernel source
>> tree.  Yes, the MODULE_LICENSE() text says GPL, so it's probably ok, but
>> to be safe, I am deleting this driver.  I will be glad to add it back if
>> the license is properly sorted out, but for now, this isn't worth the
>> potential risk, I should have never taken it in the first place.
> 
> 
>> Found to be "interesting" also by our license analysis. I think it's
>> best to purge it in CIP as well. Staging is out of scope for us
>> anyway.
> 
> Greetings to your lawyers ;-). The code is clearly derived work of
> kernel, so it has to be GPL, if Mediatek wants it or not.
> 
>> -module_init(mt_msdc_init);
>> -module_exit(mt_msdc_exit);
>> -MODULE_LICENSE("GPL");
>> -MODULE_DESCRIPTION("MediaTek MT6575 SD/MMC Card Driver");
>> -MODULE_AUTHOR("Infinity Chen <infinity.chen@mediatek.com>");
> 
> And Mediatek says so here.
> 
> Now, nobody is using that one, so removing it does little damage.
> 
> On the other hand.... nobody is using that one. You are unlikely to
> build it into your product. And yes, I can apply the patch; I'd prefer
> to get it from -stable... But that will not solve the problem.
> 
> _We will be still distributing that driver_, even if I remove it. git
> will just mark it as removed, it will still be in
> repository. (Granted, it will help with generated tarballs).
> 
> Best regards,
>     	    	  	       	    	     	       	      Pavel
> 

Let's not discuss this if there is a real issue or not. Fact is that the
programmatic declaration is not in sync with the verbal one, and that was enough
to remove the code from *upstream*. Yes, it will remain in git forever, but not
in snapshots that may be part of source packages.

So please merge.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
