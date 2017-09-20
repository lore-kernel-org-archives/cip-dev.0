From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 20 Sep 2017 11:18:15 +0900
Subject: [cip-dev] RFC: OpenEmbedded layer for CIP project
In-Reply-To: <CABMQnV+_t5dyJ43tTK+D+MAVbO4tVD0OTqL2hzp38Tc4-fCOkQ@mail.gmail.com>
References: <3c6721a5baf6437ba3a35c3c45a8b20b@svr-orw-mbx-01.mgc.mentorg.com>
	<CABMQnV+_t5dyJ43tTK+D+MAVbO4tVD0OTqL2hzp38Tc4-fCOkQ@mail.gmail.com>
Message-ID: <006301d331b6$b777ffa0$2667fee0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Sean

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Nobuhiro Iwamatsu
> Sent: Wednesday, September 20, 2017 5:03 AM
> To: Hudson, Sean
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] RFC: OpenEmbedded layer for CIP project
> 
> Hi!
> 
> 2017-09-20 0:46 GMT+09:00 Hudson, Sean <Sean_Hudson@mentor.com>:
> > Hey all,
> >
> >   I'm still new to the project and working my way through the email archives.  However, I've started creating a meta-cip layer to
> capture metadata for building the CIP project with OpenEmbedded.  This will allow it to build with the Yocto Project, as well.  I'll create
> a project on gitlab soon to start collecting my changes.
> >
> >   Any comments, concerns or thoughts?
> 
> I have not read all the archives, but CIP already has the following repository.
>   https://gitlab.com/cip-playground/project-x/tree/master/deby
> This is a layer based on meta-debian (deby).
> I think that meta-cip based on openembedded-core does not exist yet.

The Deby implementation of Project-X is using the CIP kernel and Debian Jessie source code packages.

So that means that deby uses 'bitbake' but instead of openembedded core source code (~1 year maintenance)
it uses Debian source code (~5 year maintenance). In more technical words, it uses recipes from meta-debian instead
of recipes under the meta layer.

Most probably, you can reuse most of the current implementation of Project-X by removing the meta-debian layer and
adding meta-yocto.  This can be done just by modifying the KAS project files.

We haven't decided yet officially which source code will be used for the CIP Core packages. Also we haven't decided yet what
software will be included in the CIP core packages.

Thanks,
Daniel
