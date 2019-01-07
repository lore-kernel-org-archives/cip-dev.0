From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 7 Jan 2019 06:40:30 +0100
Subject: [cip-dev] [RFC] isar-cip-core
In-Reply-To: <00ed01d4a620$26921860$73b64920$@toshiba.co.jp>
References: <f3408484-dd40-ef30-6642-dd18dfe2315a@siemens.com>
	<00ed01d4a620$26921860$73b64920$@toshiba.co.jp>
Message-ID: <1be77add-abce-e4d2-4d47-d371238390bf@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 07.01.19 01:30, Daniel Sangorrin wrote:
> Hi Jan,
> 
> Thanks for uploading isar-cip-core.
> 
> As you noticed[1], https://gitlab.com/cip-project/cip-core/ contains a folder "deby". I created that folder with the intention of adding "isar" and other tools' metadata at the same folder level.
> 
> cip-core/  <-- git repo
>      deby/ <-- deby metadata
>      isar/ <-- isar metadata
>      eid/ <-- eid metadata
> 
> [Note] Now that we have profiles (tiny and generic) we could add an extra folder for them.
> 
> I think that having all of the metadata on the same repository can be good for communication. For example, after a git-pull I might notice that you updated certain kernel configuration values under the "isar" folder that should be applied to Deby's metadata as well.

I agree that shared data like reference configs should ideally be stored in one 
place. That could be solved by having a single repos for all build systems or by 
sticking those artifacts into a separate repo. We already have 
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config - maybe add the 
configs of the reference boards there?

> 
> Another possibility is to use gitlab groups/subgroups in this way:
> 
> cip-core/ <-- group
>      tiny/ <-- subgroup
>          deby <-- git repo
>      generic/ <-- subgroup
>          isar <-- git repo
> 
> I don't have enough permissions to create groups and subgroups under cip-project though (that's the reason I used the folder approach).
> 

I do. If we agree on the group approach, we need to rename the existing cip-core 
repo first, and flatten its folder structure. Then I can create the cip-core 
group as well as the tiny/generic subgroups and move the repo.

Later on, we can factor out the kernel configs. Do you see other shared data?

> Which way would you prefer?

I'm leaning towards separate repos.

Jan

> 
> Thanks,
> Daniel
> 
> [1] https://gitlab.com/cip-project/cip-core/issues/2

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
