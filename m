From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Wed, 20 Sep 2017 05:03:19 +0900
Subject: [cip-dev] RFC: OpenEmbedded layer for CIP project
In-Reply-To: <3c6721a5baf6437ba3a35c3c45a8b20b@svr-orw-mbx-01.mgc.mentorg.com>
References: <3c6721a5baf6437ba3a35c3c45a8b20b@svr-orw-mbx-01.mgc.mentorg.com>
Message-ID: <CABMQnV+_t5dyJ43tTK+D+MAVbO4tVD0OTqL2hzp38Tc4-fCOkQ@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

2017-09-20 0:46 GMT+09:00 Hudson, Sean <Sean_Hudson@mentor.com>:
> Hey all,
>
>   I'm still new to the project and working my way through the email archives.  However, I've started creating a meta-cip layer to capture metadata for building the CIP project with OpenEmbedded.  This will allow it to build with the Yocto Project, as well.  I'll create a project on gitlab soon to start collecting my changes.
>
>   Any comments, concerns or thoughts?

I have not read all the archives, but CIP already has the following repository.
  https://gitlab.com/cip-playground/project-x/tree/master/deby
This is a layer based on meta-debian (deby).
I think that meta-cip based on openembedded-core does not exist yet.

>
> --
> Sean
>

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
