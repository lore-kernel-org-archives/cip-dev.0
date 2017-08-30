From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:27:08 +0200
Subject: [cip-dev] [PATCH 00/14] EFI capsule update support for IOT2000
	devices
In-Reply-To: <CAKv+Gu9k94FZbakSZz3VtXPr+e921q=m6OkeYiJ-4y0OhT2-Pw@mail.gmail.com>
References: <cover.1504120436.git.jan.kiszka@siemens.com>
	<CAKv+Gu9k94FZbakSZz3VtXPr+e921q=m6OkeYiJ-4y0OhT2-Pw@mail.gmail.com>
Message-ID: <93fd99e5-da27-49cc-86af-b9b8c4db1f6a@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-08-30 21:24, Ard Biesheuvel wrote:
> Hello Jan,
> 
> On 30 August 2017 at 20:13, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> Last chunk: This backports EFI capsule updates, primarily for the use
>> with the IOT2020 and IOT2040, the latter with Quark-proprietary security
>> header format. The feature should also work for the Galileo Gen 2 and,
>> at least conceptually, for any EFI capsule update compatible firmware.
>>
> 
> What is the purpose of this series? I hope you are not expecting this
> to be considered for -stable?
> Please check Documentation/process/stable-kernel-rules.rst for
> guidelines on what is appropriate for -stable.

Argh, sorry. Missed that I didn't activate the CC filter for this one.

Everyone except for Ben and cip-dev, please ignore - this is just a
backport to the CIP SLTS kernel.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
