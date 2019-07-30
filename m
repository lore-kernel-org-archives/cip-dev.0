From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Tue, 30 Jul 2019 10:08:33 +0000
Subject: [cip-dev] phy-rcar-gen3-usb2: wrong parsing of role in
	role_store?
In-Reply-To: <20190730095140.GA29609@amd>
References: <20190730095140.GA29609@amd>
Message-ID: <TYAPR01MB4544F1EE39C3A9F36B13D49AD8DC0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> From: Pavel Machek, Sent: Tuesday, July 30, 2019 6:52 PM
> 
> Hi!
> 
> Code does strcmps, but does not actually check count. So AFAICT
> writing "host-I-don't-want-I-need-peripheral" into the file will
> succeed and turn it into host mode.
> 
> Also data beyond count in buf are going to be accessed.

Thank you for the report. I think the driver should use sysfs_streq() helper
instead of strncmp() on the sysfs function. So, I'll submit such a patch later.

Best regards,
Yoshihiro Shimoda

> Best regards,
> 								Pavel
> 
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
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
