{ ... }:
{
programs.mangohud = {
  enable = true;

  settings = {
    # Расположение и внешний вид
    position = "top-left";
    font_size = 18;
    background_alpha = 0.35;
    round_corners = 8;
    table_columns = 3;
    text_outline = true;

    # FPS и плавность
    fps = true;
    frametime = true;
    frame_timing = true;
    dynamic_frame_timing = true;
    fps_metrics = "avg,0.01,0.001";
    fps_sampling_period = 500;
    show_fps_limit = true;

    # Видеокарта
    gpu_stats = true;
    gpu_name = true;
    gpu_temp = true;
    gpu_core_clock = true;
    gpu_mem_clock = true;
    gpu_power = true;
    gpu_power_limit = true;
    gpu_fan = true;
    gpu_efficiency = true;
    throttling_status = true;

    # Видеопамять
    vram = true;
    proc_vram = true;

    # Процессор
    cpu_stats = true;
    cpu_temp = true;
    cpu_mhz = true;
    cpu_power = true;
    cpu_efficiency = true;

    # Загрузка каждого ядра — поможет увидеть упор в одно ядро
    core_load = true;
    core_load_change = true;

    # Оперативная память и swap
    ram = true;
    swap = true;

    # Память непосредственно игрового процесса
    procmem = true;
    procmem_shared = true;

    # Чтение и запись игры на накопитель
    io_read = true;
    io_write = true;

    # Информация об игре и графическом стеке
    engine_version = true;
    wine = true;
    winesync = true;
    present_mode = true;
    gamemode = true;
    resolution = true;
    display_server = true;
    exec_name = true;
    arch = true;
  };
};

}
