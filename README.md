# latitude-7370-catalina
Mac OS con opencore

Funciona:
* Battery info
* Trackpad
* Camera
* Audio (parlantes y mic internos + audifonos, ver carpeta)
* Cerrarla la manda a sleep
* target 67 -> para que deje logs de booteo apagado
* wifi de intel, usar con app: Heliport (mapea wifi a red ethernet lol)
* subir y bajar y mute de volumen, brillo funciona pero no con los botones :s

para fixear about this mac:\
  Under PlatformInfo/Generic:\
  Set UpdateSMBIOSMode to Custom.\
  Under Kernel/Quriks, set CustomSMBIOSGuid to true
