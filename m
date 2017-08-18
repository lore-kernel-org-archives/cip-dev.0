From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 18 Aug 2017 14:38:59 +0100
Subject: [cip-dev] Kernel feature support - architecture options and
 drivers
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445B96609D@GSjpTKYDCembx31.service.hitachi.net>
References: <1500643130.12197.123.camel@codethink.co.uk>
	<04EAB7311EE43145B2D3536183D1A8445B96609D@GSjpTKYDCembx31.service.hitachi.net>
Message-ID: <1503063539.2047.90.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2017-07-28 at 04:49 +0000, ???? / KAWAI?HIDEHIRO wrote:
> Hello Ben,
> 
> I'm sorry for the late reply.

Likewise. :-/

[...]
> > KVM (CONFIG_VIRTUALIZATION) adds a large attack surface (guest-to-host)
> > and is likely to be hard to maintain in the long term.  Several of the
> > configurations (hitachi_omap, plathome_obsvx1, siemens_iot2000,
> > siemens_server) enable this.  Do you need it?
> 
> It is not used at this point, but may be need in the future.
> 
> As long as we don't use KVM to build up a multi tenant VM service,
> i.e. all users are the same legitimate user, the security risk of
> guest-to-host attack will not become higher.  So with regard to the
> security risk, it will not be a problem for some use cases.

Even when the guests are running known trusted code, that code might
have its own security flaws.  KVM then potentially provides a useful
security boundary between a compromised guest and the host.  But I take
your point - if the code running in the guest is trusted and security
supported, an outdated KVM doesn't add significant extra risk.

> > /dev/kmem (CONFIG_DEVKMEM) is only rarely needed for kernel debugging,
> > but is enabled in many configs.  Please disable it.
> > 
> > /dev/mem (CONFIG_DEVMEM) is needed by some userland drivers, though UIO
> > provides a cleaner way to do this.  Please check whether you can disable
> > it.
> 
> I tried to grep executable files in /usr/{bin,sbin}, and I found multiple
> commands which may access /dev/mem.  But I'm not sure how much impact
> disabling /dev/mem has on us.  We also use /dev/mem for a user land
> driver, but we will be able to reimplement it via UIO.
> 
> 
> By the way, I think that `supporting a feature' is not the same as
> `enabling a feature'.  Does `please disable it' mean that this is a
> suggestion for a secure config, or imply that CIP shouldn't support
> this feature?

Where I said 'please disable it' with no qualification, I think the
feature is inherently insecure and I don't think CIP should pretend to
provide security support for it.

Where I said something like 'check whether you can disable it', I
consider the feature to be high risk, but CIP should try to support it
if members need it.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
