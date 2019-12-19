From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Dec 2019 21:35:44 +0100
Subject: [cip-dev] [Y2038] [PATCH] generic/402: fix for updated behavior
 of timestamp limits
In-Reply-To: <f913d1f409dd4b2a22bcb71a3ddaeb2b87a00671.camel@codethink.co.uk>
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
 <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
 <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
 <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
 <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
 <20191219084046.GA1026636@kroah.com>
 <CAK8P3a1HiPLbajjoYQf0N4RBw9eUK6uyC+mOq7LaRmNpgiOgLA@mail.gmail.com>
 <f913d1f409dd4b2a22bcb71a3ddaeb2b87a00671.camel@codethink.co.uk>
Message-ID: <CAK8P3a2bJxxrCFVLcduMykHjBMshA8B2EdV0xeFOOY5fARiN4g@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, Dec 19, 2019 at 4:48 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Thu, 2019-12-19 at 12:29 +0100, Arnd Bergmann wrote:
> [...]
> > - Users of CIP SLTS kernels with extreme service life that may involve
> >   not upgrading until after y2038 (this is obviously not recommended if
> >   you connect to a public network, but I'm sure some people do this anyway).
> >   For running user space, this requires either a 32-bit kernel with the
> >   linux-5.1 syscall changes or a 64-bit kernel. If you run a 64-bit linux-4.9
> >   kernel in a deeply embedded non-networked machine, it still makes
> >   sense to have working inode timestamps and be able to test that.
> [...]
>
> CIP is currently aiming for a 10 year support lifetime, so both of its
> currently existing branches (4.4, 4.19) should be long out of support
> in 2038.  Still, it's possible that some people hope to extend that
> later.

It is also common that end-users keep relying on machines that they
bought for many years after any support contracts end. This may be
fine for a lot of use cases where there is no risk in running an old
operating system, and replacing it is prohibitively expensive, as
software generally does not suddenly stop working after support ends.

With the y2038-safe interfaces and with file system limits, the
difference is that there is a specific point in time when things will
break.

        Arnd
