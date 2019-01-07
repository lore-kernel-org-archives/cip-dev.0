From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 7 Jan 2019 09:30:11 +0900
Subject: [cip-dev] [RFC] isar-cip-core
In-Reply-To: <f3408484-dd40-ef30-6642-dd18dfe2315a@siemens.com>
References: <f3408484-dd40-ef30-6642-dd18dfe2315a@siemens.com>
Message-ID: <00ed01d4a620$26921860$73b64920$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

Thanks for uploading isar-cip-core.

As you noticed[1], https://gitlab.com/cip-project/cip-core/ contains a folder "deby". I created that folder with the intention of adding "isar" and other tools' metadata at the same folder level.

cip-core/  <-- git repo
    deby/ <-- deby metadata
    isar/ <-- isar metadata
    eid/ <-- eid metadata

[Note] Now that we have profiles (tiny and generic) we could add an extra folder for them.

I think that having all of the metadata on the same repository can be good for communication. For example, after a git-pull I might notice that you updated certain kernel configuration values under the "isar" folder that should be applied to Deby's metadata as well.

Another possibility is to use gitlab groups/subgroups in this way:

cip-core/ <-- group
    tiny/ <-- subgroup
        deby <-- git repo
    generic/ <-- subgroup
        isar <-- git repo

I don't have enough permissions to create groups and subgroups under cip-project though (that's the reason I used the folder approach).

Which way would you prefer?

Thanks,
Daniel

[1] https://gitlab.com/cip-project/cip-core/issues/2

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On Behalf Of Jan Kiszka
> Sent: Friday, January 4, 2019 3:03 AM
> To: cip-dev <cip-dev@lists.cip-project.org>
> Subject: [cip-dev] [RFC] isar-cip-core
> 
> Hi,
> 
> happy new year to everyone!
> 
> New year, new project: I've started isar-cip-core in our incubating area, see
> https://gitlab.com/cip-playground/isar-cip-core.
> 
> It's currently only generating an SD card image for the BeagleBone Black, but
> that can easily be extended. The idea is to model our generic profile CIP Core
> this way, producing images that contain all supported packages and can then be
> used for testing, evaluation etc.
> 
> README is still missing, will write one tomorrow:
> 
> # wget https://raw.githubusercontent.com/siemens/kas/master/kas-docker
> # chmod a+x kas-docker
> # ./kas-docker --isar build kas.yml:board-bbb.yml
> 
> or
> 
> # ./kas-docker --isar build kas.yml:board-bbb.yml:opt-rt.yml
> 
> for the RT variant.
> 
> Looking forward to feedback!
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
