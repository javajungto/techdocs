# upower
```
apt install upower
upower
upower -e
upower -i /org/freedesktop/UPower/devices/battery_BAT0
```
```
# upower -i /org/freedesktop/UPower/devices/battery_BAT0
  native-path:          BAT0
  vendor:               HP
  model:                Primary
  serial:               SerialNumber
  power supply:         yes
  updated:              Thu 30 May 2024 10:44:01 AM KST (0 seconds ago)
  has history:          yes
  has statistics:       yes
  battery
    present:             yes
    rechargeable:        yes
    state:               charging
    warning-level:       none
    energy:              37.26 Wh
    energy-empty:        0 Wh
    energy-full:         38.334 Wh
    energy-full-design:  38.334 Wh
    energy-rate:         4.723 W
    voltage:             12.902 V
    charge-cycles:       28
    time to full:        13.6 minutes
    percentage:          97%
    capacity:            100%
    technology:          lithium-ion
    icon-name:          'battery-full-charging-symbolic'
  History (charge):
    1717033385	97.000	charging
  History (rate):
    1717033441	4.723	unknown
    1717033440	4.747	charging
    1717033439	4.712	charging
    1717033437	4.735	charging
    1717033436	4.747	charging
    1717033435	4.758	charging
    1717033434	4.770	charging
    1717033433	4.723	charging
    1717033432	4.770	charging
    1717033378	4.930	charging
```
