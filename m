From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 23 Oct 2017 18:38:25 +0900
Subject: [cip-dev] Status of cip-core
Message-ID: <003901d34be2$acfa4010$06eec030$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

I have updated the cip-core quickstart instructions:
Ref: https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-core-quickstart

I have checked that they work for iwg20m and bbb. They should work for qemu and
cyclonev as well, but building targets takes a long time so I couldn't finish it today.

Additionally, I have upgraded cip-core to morty and KAS files to 0.13.0.
# now jethro (legacy) files are on their own branch, and morty (next release) is on the master branch

You can test the morty version as follows:
host$ git clone https://gitlab.com/cip-project/cip-core.git
host$ docker run -v $PWD/cip-core:/cip-core -e USER_ID=`id -u $USER` -e http_proxy=$http_proxy -e https_proxy=$https_proxy -e NO_PROXY="$no_proxy" -it kasproject/kas:0.13.0 sh
docker$ cd /cip-core/deby/poky/
docker$ kas build --target core-image-minimal meta-cip-iwg20m/kas-iwg20m.yml
[Alt] kas build --target core-image-minimal meta-cip-bbb/kas-bbb.yml

Current issues:
- KAS is using a single the same "build" folder for all targets, and this causes conflicts.
Until I figure out how to specify the name of the build folder, please delete the build/tmp
folder before building each target.
Jan: what is KAS_WORK_DIR in http://kas.readthedocs.io/en/latest/userguide.html#environment-variables?
- modules.tgz is not generated for iwg20m (for bbb it is): I have to investigate why but I think 
it is not a big problem since they are included in the file system images. Probably the reason
is just that shmobile_defconfig has modules disabled.
- B at D: there are some slight changes needed so I will send an updated version of the patches.

Cheers,
Daniel







 
