From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 27 Mar 2017 13:40:52 +0200
Subject: [cip-dev] Kernel feature support
In-Reply-To: <d71c9a03-d9cb-2793-dd9e-9d198e8079f1@siemens.com>
References: <1489070021.2949.73.camel@codethink.co.uk>
	<58C9695D.9090908@codethink.co.uk>
	<d71c9a03-d9cb-2793-dd9e-9d198e8079f1@siemens.com>
Message-ID: <da4b949b-a763-9c55-b96e-bf41cf0f6af8@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-03-27 12:31, Gernot Hillier wrote:
> On 15.03.2017 17:18, Agustin Benito Bethencourt wrote:
>> Hi,
>>
>> On 09/03/17 15:33, Ben Hutchings wrote:
>>> We've previously agreed that not all kernel features (drivers,
>>> filesystems, network protocols, etc.) can be supported in an SLTS
>>> branch.  I'd like to start working out what the supported features
>>> should be for the 4.4 branch.
>>>
>>> Are members able to share their kernel .config files, showing which
>>> features are enabled?  Or would you prefer to specify your needs at a
>>> slightly higher level?
>>
>> Answering this question is important to discard features in 4.4 that are
>> not of CIP interest so we can severely reduce the amount of effort that
>> we will need to do in terms of fixes analysis, security etc. in the future.
>>
>> Please take some time to provide feedback.
> 
> Sorry for the late reply!

Fell through my cracks as well, just sending out another internal call
for more product configs. One is attached already, derived from
github.com/siemens/meta-iot2000.

> 
> Please find attached an x86 kernel configuration from early product
> development using kernel 4.4.
> 
> This product uses nearly-COTS server hardware due to needed computation
> power, but also comes with nice embedded requirements like longterm
> maintenance - and as a special need, real-time support, so we use
> Linux-Ipipe/Xenomai here.
> 
> This means two things:
> * many included drivers (especially in net and storage) are only
>   activated "to be prepared" for future hw replacements
> * Feel free to either include Xenomai on your list as a used "kernel
>   feature" or to ignore the related options.

Xenomai is not in CIP scope right now (though Siemens would welcome
anyone interested in collaborating on it).

In general, anything in a config not part of upstream is filtered out
"automatically", I would say. There are switches for out-of-tree
features in the iot2000 config as well (we are still in the process of
upstreaming).

> 
> So same as with the config from Hidehiro Kawai: please let me know if
> you need prioritized list of drivers or other features!
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.bz2
Type: application/x-bzip
Size: 21169 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170327/64a8370d/attachment-0001.bin>
