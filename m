From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 01 Aug 2019 19:51:02 +0100
Subject: [cip-dev] phy-rcar-gen3-usb2: wrong parsing of role in
 role_store?
In-Reply-To: <20190730095140.GA29609@amd>
References: <20190730095140.GA29609@amd>
Message-ID: <ffe639374bd93fe76f4aed19883640fefebd08f4.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2019-07-30 at 11:51 +0200, Pavel Machek wrote:
> Hi!
> 
> Code does strcmps, but does not actually check count. So AFAICT
> writing "host-I-don't-want-I-need-peripheral" into the file will
> succeed and turn it into host mode.

I suspect the intent is to work without a trailing "\n", but you're
right that this parsing is rather lax.

> Also data beyond count in buf are going to be accessed.

All attribute writes should be going through kernfs_fop_write(), which
writes a null terminator at buf[count] before calling the write/store
function.  (I don't know where that'ss documented though.)  So I think
this is safe.

Ben.

> static ssize_t role_store(struct device *dev, struct device_attribute *attr,
>                           const char *buf, size_t count)
> {
>         struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
>         bool is_b_device;
>         enum phy_mode cur_mode, new_mode;
> 
>         if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
>                 return -EIO;
> 
>         /* FIXME, this is wrong */
>         if (!strncmp(buf, "host", strlen("host")))
>                 new_mode = PHY_MODE_USB_HOST;
>         else if (!strncmp(buf, "peripheral", strlen("peripheral")))
>                 new_mode = PHY_MODE_USB_DEVICE;
>         else
>                 return -EINVAL;
> 
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
